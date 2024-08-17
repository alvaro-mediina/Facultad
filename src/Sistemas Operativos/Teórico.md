# 💻 Teórico de Sistemas Operativos 💾

En este archivo encontrarás un resumen o algunas ideas sobre el libro OSTEP (Operating Systems: Three Easy Pieces) y otros temas relacionados con sistemas operativos.

Como la materia se divide en 3 partes, también dividiré este archivo en 3 partes, una para cada parte del libro.

Enjoy :D

# Indice
- [Introducción](#introducción)
   * [Introducción a los Sistemas Operativos](#introducción-a-los-sistemas-operativos)
   * [Virtualizando la CPU](#virtualizando-la-cpu)
   * [Virtualizando la Memoria](#virtualizando-la-memoria)
   * [Concurrencia](#concurrencia)
    * [Persistencia](#persistencia)
    * [Desiciones de diseño](#desiciones-de-diseño)
    * [Un poco de historia](#un-poco-de-historia)
- [Virtualización](#virtualizacion)

# Introducción

 Las tres piezas fáciles se refieren a los tres elementos temáticos principales en los que se organiza el libro: virtualización, concurrencia y persistencia. Al discutir estos conceptos, terminaremos hablando de la mayoría de las cosas importantes que hace un sistema operativo; con suerte, también se divertirán en el camino.

 - El primero es el `crux` del problema. Cada vez que tratamos de resolver un problema, primero intentamos declarar cuál es el tema más importante; dicho crux del problema se señala explícitamente en el texto, y esperamos que se resuelva a través de las técnicas, algoritmos e ideas presentadas en el resto del texto. 
 - En muchos lugares, explicaremos cómo funciona un sistema mostrando su comportamiento a lo largo del tiempo. Estas líneas de tiempo son la esencia de la comprensión; si sabes qué ocurre, estarás en camino a entender verdaderamente cómo opera la memoria virtual. 
 
 - Si comprendes lo que sucede cuando un sistema de archivos con journaling escribe un bloque en el disco, habrás dado los primeros pasos hacia el dominio de los sistemas de almacenamiento.

 - Al principio de cada sección principal, primero presentaremos una `abstracción` que un sistema operativo proporciona, y luego trabajaremos en los capítulos siguientes sobre los mecanismos, políticas y otros apoyos necesarios para proporcionar esa abstracción. 
    * Las abstracciones son fundamentales en todos los aspectos de la Ciencia de la Computación, por lo que no es sorprendente que también sean esenciales en los sistemas operativos.

> **Consejo**:  Asiste a clase, para escuchar al profesor presentar el material. Luego, al final de cada semana, lee estas notas, para ayudar a que las ideas se asienten un poco mejor en tu mente. Por supuesto, algún tiempo después (pista: antes del examen), vuelve a leer las notas para consolidar tu conocimiento. Por supuesto, tu profesor sin duda asignará algunas tareas y proyectos, así que deberías hacerlos; en particular, hacer proyectos donde escribas código real para resolver problemas reales es la mejor manera de poner en práctica las ideas de estas notas. 

## Introducción a los Sistemas Operativos

> **El CRUX del problema: Cómo virtualizar los recursos**: El porqué el sistema operativo hace esto no es la pregunta principal, ya que la respuesta debería ser obvia: hace que el sistema sea más fácil de usar. Por lo tanto, nos enfocamos en el cómo: ¿qué mecanismos y políticas implementa el sistema operativo para lograr la virtualización? ¿Cómo lo hace de manera eficiente? ¿Qué soporte de hardware es necesario?

### Virtualizando la CPU

Si sólo tenemos un procesador ¿Cómo ocurre la magia de correr programas al mismo tiempo? Resulta que el sistema operativo, con algo de ayuda del hardware, es el encargado de crear esta ilusión, es decir, la ilusión de que el sistema tiene un número muy grande de CPUs virtuales. Convertir un solo CPU (o un pequeño conjunto de ellos) en un número aparentemente infinito de CPUs y, por lo tanto, permitir que muchos programas se ejecuten aparentemente al mismo tiempo es lo que llamamos virtualización de la CPU.

Por supuesto, para ejecutar programas, detenerlos y, en general, indicarle al sistema operativo qué programas ejecutar, deben existir algunas interfaces (APIs) que puedes usar para comunicar tus deseos al sistema operativo. Hablaremos sobre estas APIs a lo largo del libro; de hecho, son la principal forma en que la mayoría de los usuarios interactúa con los sistemas operativos.
    
### Virtualizando la Memoria

Ahora consideremos la memoria. El modelo de memoria física presentado por las máquinas modernas es muy simple. La memoria es simplemente un array de bytes; para leer la memoria, se debe especificar una dirección para poder acceder a los datos almacenados allí; para escribir (o actualizar) memoria, también se debe especificar los datos a escribir en la dirección dada.

La memoria se accede todo el tiempo cuando un programa está en ejecución. Un programa mantiene todas sus estructuras de datos en memoria y accede a ellas mediante diversas instrucciones, como cargas y almacenamientos, o otras instrucciones explícitas que acceden a la memoria para realizar su trabajo. No olvides que cada instrucción del programa también está en memoria; por lo tanto, la memoria se accede en cada recuperación de instrucción.

```C
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/time.h>
#include <time.h>

void Spin(int seconds) {
    time_t start = time(NULL);
    while (time(NULL) - start < seconds) {
        // Bucle vacío que consume tiempo
    }
}

int main(int argc, char *argv[]){
    int *p = malloc(sizeof(int)); // a1
    assert(p != NULL);
    printf("(%d) address pointed to by p: %p\n", getpid(), p); // a2
    *p = 0; // a3
    while (1) {
        Spin(1);
        *p = *p + 1;
        printf("(%d) p: %d\n", getpid(), *p); // a4
    }
    return 0;
}
```
El programa hace un par de cosas. Primero, asigna algo de memoria (línea a1). Luego, imprime la dirección de la memoria (a2) y, a continuación, coloca el número cero en la primera posición de la memoria recién asignada (a3). Finalmente, entra en un bucle, retrasándose durante un segundo e incrementando el valor almacenado en la dirección contenida en p. Con cada declaración de impresión, también muestra lo que se llama el identificador del proceso (PID) del programa en ejecución. Este PID es único para cada proceso en ejecución. Nuevamente, este primer resultado no es muy interesante. La memoria recién asignada está en la dirección 0x200000. A medida que el programa se ejecuta, actualiza lentamente el valor y muestra el resultado.

```bash
$ gcc -o mem mem.c
[1] 15998
(15999) address pointed to by p: 0x5b34db0ce2a0
(15998) address pointed to by p: 0x578a0f4c02a0
(15999) p: 1
(15998) p: 1
(15998) p: 2
(15999) p: 2
(15999) p: 3
(15998) p: 3
(15999) p: 4
(15998) p: 4
(15999) p: 5
(15998) p: 5
(15998) p: 6
(15999) p: 6
(15999) p: 7
(15998) p: 7
(15998) p: 8
(15999) p: 8
(15999) p: 9
(15998) p: 9

```

Ahora, ejecutamos varias instancias de este mismo programa para ver qué sucede (Figura 2.4). Vemos en el ejemplo que cada programa en ejecución ha asignado memoria en la misma dirección (0x578a0f4c02a0), ¡y sin embargo, cada uno parece estar actualizando el valor en 0x578a0f4c02a0 de forma independiente! Es como si cada programa en ejecución tuviera su propia memoria privada, en lugar de compartir la misma memoria física con otros programas en ejecución. De hecho, eso es exactamente lo que está sucediendo aquí, ya que el sistema operativo está virtualizando la memoria. Cada proceso accede a su propio espacio de direcciones virtuales privado (a veces simplemente llamado su espacio de direcciones), que el sistema operativo mapea de alguna manera a la memoria física de la máquina. Una referencia de memoria dentro de un programa en ejecución no afecta el espacio de direcciones de otros procesos (o del propio sistema operativo); en lo que respecta al programa en ejecución, tiene la memoria física solo para sí mismo. La realidad, sin embargo, es que la memoria física es un recurso compartido, gestionado por el sistema operativo. 

### Concurrencia

Usamos este término conceptual para referirnos a una serie de problemas que surgen y deben ser abordados cuando se trabaja en muchas cosas al mismo tiempo (es decir, concurrentemente) en el mismo programa. Los problemas de concurrencia surgieron primero dentro del propio sistema operativo; como puedes ver en los ejemplos anteriores sobre virtualización, el sistema operativo está manejando muchas cosas a la vez, ejecutando primero un proceso, luego otro, y así sucesivamente. Resulta que hacer esto lleva a problemas profundos e interesantes

> El CRUX del problema:
Cuando hay muchos hilos ejecutándose concurrentemente dentro del mismo espacio de memoria, ¿cómo podemos construir un programa que funcione correctamente? ¿Qué primitivas se necesitan del sistema operativo? ¿Qué mecanismos deben proporcionar el hardware? ¿Cómo podemos usarlos para resolver los problemas de concurrencia?

### Persistencia

El tercer tema principal del curso es la persistencia. En la memoria del sistema, los datos pueden perderse fácilmente, ya que dispositivos como la DRAM almacenan valores de manera volátil; cuando se corta la energía o el sistema falla, cualquier dato en memoria se pierde. Por lo tanto, necesitamos hardware y software capaces de almacenar datos de manera persistente.

El software en el sistema operativo que generalmente gestiona el disco se llama el sistema de archivos; por lo tanto, es responsable de almacenar cualquier archivo que el usuario cree de manera confiable y eficiente en los discos del sistema.

A diferencia de las abstracciones proporcionadas por el sistema operativo para la CPU y la memoria, el sistema operativo no crea un disco virtualizado privado para cada aplicación. Más bien, se asume que, a menudo, los usuarios querrán compartir información que está en archivos.

### Desiciones de diseño

Un objetivo en el diseño e implementación de un sistema operativo es proporcionar un alto rendimiento; otra forma de decirlo es que nuestro objetivo es minimizar los sobrecostos del OS.

Otro objetivo será proporcionar protección entre aplicaciones, así como entre el OS y las aplicaciones. Debido a que queremos permitir que muchos programas se ejecuten al mismo tiempo, queremos asegurarnos de que el comportamiento malicioso o accidentalmente incorrecto de uno no dañe a los demás; ciertamente no queremos que una aplicación pueda dañar el propio OS (ya que eso afectaría a todos los programas que se ejecutan en el sistema). La protección es el corazón de uno de los principales principios subyacentes de un sistema operativo, que es el de aislamiento; aislar procesos unos de otros es clave para la protección y, por lo tanto, subyace en gran parte de lo que un OS debe hacer.

### Un poco de historia

#### Primeros Sistemas Operativos: Solo Bibliotecas

En sus inicios, los sistemas operativos (OS) eran bastante rudimentarios, funcionando esencialmente como bibliotecas de funciones comunes. En lugar de que cada programador escribiera código para manejar I/O de bajo nivel, el "OS" proporcionaba APIs para facilitar el desarrollo. En estos sistemas de mainframe antiguos, solo se ejecutaba un programa a la vez, controlado por un operador humano. Mucho de lo que hoy consideramos funciones básicas de un OS (como decidir el orden de ejecución de trabajos) lo hacía este operador. Este modo de procesamiento se conocía como procesamiento por lotes (batch processing), donde una serie de trabajos se configuraban y se ejecutaban en "lote" por el operador. Dado que era costoso permitir que un usuario interactuara directamente con la computadora, se utilizaba principalmente el procesamiento por lotes [BH00].

#### Más Allá de las Bibliotecas: Protección

A medida que los sistemas operativos evolucionaron, asumieron un papel más central en la gestión de las máquinas. Un aspecto importante fue reconocer que el código ejecutado en nombre del OS debía ser especial y tratado de manera diferente al código de aplicación normal. Permitir que cualquier aplicación leyera cualquier archivo en el disco comprometía la privacidad. Por lo tanto, se inventó la llamada a sistema (system call), un mecanismo que permitió la transición controlada al OS, elevando el nivel de privilegio del hardware. En contraste con una llamada a procedimiento, una llamada a sistema transfiere el control al OS mientras eleva el nivel de privilegio del hardware. Esto permitió al OS tener acceso completo al hardware y realizar operaciones como solicitudes de I/O o gestionar memoria. Una vez completada la solicitud, el control se devuelve al usuario.

#### La Era del Multiprogramming
Con la llegada de las minicomputadoras, los sistemas operativos dieron un gran salto. Las máquinas clásicas como la PDP de Digital Equipment hicieron que las computadoras fueran más asequibles, permitiendo que un grupo menor de personas dentro de una organización tuviera su propia máquina. Esto impulsó la actividad de desarrollo y la innovación en los sistemas operativos, especialmente con la multiprogramación. En lugar de ejecutar un solo trabajo a la vez, el OS cargaba múltiples trabajos en memoria y cambiaba rápidamente entre ellos para mejorar la utilización del CPU. La necesidad de soportar multiprogramación y la superposición en presencia de I/O e interrupciones llevó a importantes innovaciones en la protección de memoria y el manejo de la concurrencia. La introducción del sistema operativo UNIX por Ken Thompson y Dennis Ritchie en Bell Labs fue un avance significativo, al simplificar y hacer más accesibles muchas ideas buenas de otros sistemas [O72, B+72, S68].

#### La Era Moderna
La llegada de las computadoras personales (PC) marcó una nueva era en la informática. Las primeras PCs, como el Apple II y el IBM PC, se convirtieron en la fuerza dominante en la computación debido a su bajo costo. Sin embargo, los primeros sistemas operativos de PC, como DOS, olvidaron o nunca aprendieron las lecciones de las minicomputadoras, como la protección de memoria. Los primeros sistemas operativos de Mac (hasta la versión 9) tenían un enfoque cooperativo para la programación, lo que permitía que un hilo atrapado en un bucle infinito pudiera tomar el control completo del sistema. Afortunadamente, con el tiempo, las características avanzadas de los sistemas operativos de minicomputadoras comenzaron a integrarse en los sistemas de escritorio. Hoy en día, sistemas como macOS, basado en UNIX, y Windows NT han adoptado muchas de las grandes ideas de la historia de la computación. Incluso los teléfonos móviles modernos, que ejecutan sistemas operativos como Linux, se asemejan más a los sistemas de minicomputadoras de los años 70 que a los PC de los años 80. Es gratificante ver cómo las buenas ideas del pasado continúan evolucionando y mejorando los sistemas modernos.

#### ASIDE: La importancia de UNIX

Es difícil exagerar la importancia de UNIX en la historia de los sistemas operativos. Influenciado por sistemas anteriores, en particular el famoso sistema Multics del MIT, UNIX reunió muchas ideas innovadoras y creó un sistema tanto simple como poderoso. El principio unificador subyacente al UNIX original de "Bell Labs" era la construcción de pequeños programas potentes que podían conectarse entre sí para formar flujos de trabajo más grandes. El shell, donde se escriben los comandos, proporcionaba primitivas como los pipes (tuberías) para habilitar tal programación a nivel meta, facilitando la conexión de programas para lograr una tarea más compleja.

Por ejemplo, para encontrar líneas en un archivo de texto que contengan la palabra "foo" y luego contar cuántas de esas líneas existen, se escribiría: grep foo file.txt | wc -l, utilizando así los programas grep y wc (word count) para cumplir la tarea. El entorno UNIX era amigable tanto para programadores como para desarrolladores, proporcionando también un compilador para el nuevo lenguaje de programación C. Facilitar que los programadores escribieran sus propios programas, así como compartirlos, hizo que UNIX se volviera enormemente popular. Probablemente también ayudó mucho que los autores distribuyeran copias gratuitamente a quien las solicitara, una forma temprana de software de código abierto.

Otra de las características críticas fue la accesibilidad y legibilidad del código. Tener un kernel hermoso y pequeño escrito en C invitaba a otros a jugar con él, agregando nuevas y geniales funcionalidades. Por ejemplo, un grupo emprendedor en Berkeley, liderado por Bill Joy, creó una maravillosa distribución (la Berkeley Systems Distribution, o BSD) que incluía subsistemas avanzados de memoria virtual, sistemas de archivos y redes. Joy luego cofundó Sun Microsystems.

Desafortunadamente, la expansión de UNIX se vio un poco frenada cuando algunas empresas intentaron reclamar su propiedad y lucrar con él, un resultado desafortunado (pero común) cuando los abogados se involucran. Muchas empresas desarrollaron sus propias variantes: SunOS de Sun Microsystems, AIX de IBM, HPUX (conocido como "H-Pucks") de HP, e IRIX de SGI. Las disputas legales entre AT&T/Bell Labs y estos otros actores arrojaron una sombra sobre UNIX, y muchos se preguntaban si sobreviviría, especialmente con la introducción de Windows, que se apoderó de gran parte del mercado de PCs...

#### ASIDE: Y luego llegó Linux

Afortunadamente para UNIX, un joven hacker finlandés llamado Linus Torvalds decidió escribir su propia versión de UNIX, la cual se basaba en gran medida en los principios e ideas del sistema original, pero no en su base de código, evitando así problemas legales. Torvalds contó con la ayuda de muchas personas de todo el mundo y aprovechó las sofisticadas herramientas GNU que ya existían [G85], y pronto nació Linux (así como el movimiento moderno de software de código abierto).

Con la llegada de la era de internet, la mayoría de las empresas (como Google, Amazon, Facebook y otras) optaron por usar Linux, ya que era gratuito y podía modificarse fácilmente para satisfacer sus necesidades; de hecho, es difícil imaginar el éxito de estas nuevas compañías si un sistema así no hubiera existido. A medida que los teléfonos inteligentes se convirtieron en una plataforma dominante para los usuarios, Linux también encontró un bastión allí (a través de Android), por muchas de las mismas razones. Además, Steve Jobs llevó consigo su entorno operativo basado en UNIX, NeXTStep, a Apple, lo que hizo que UNIX fuera popular en los escritorios (aunque muchos usuarios de la tecnología de Apple probablemente no sean conscientes de este hecho).

Así, UNIX sigue vivo, más importante hoy que nunca. Los dioses de la computación, si crees en ellos, deberían ser agradecidos por este maravilloso resultado.










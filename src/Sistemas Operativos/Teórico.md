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
    * [Dialogo](#dialogo)
    * [Procesos](#procesos)

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

# Virtualización

## Procesos

Definición informal: Programa en ejecución

El programa en sí mismo es una cosa sin vida: solo está allí en el disco, un monton de instrucciones (y quizás ́algunos datos estáticos), esperando entrar en acción. Es el sistema  ́operativo el que toma estos bytes y los pone en marcha, transformando el programa en algo util.

---
### El problema en cuestión:
¿Cómo proporcionar la ilusión de muchas CPU's? A pesar de que solo hay unas pocas CPUs físicas disponibles, ¿Como puede el sistema operativo proporcionar la ilusion de un suministro casi infinito de dichas CPUs?

---

El sistema operativo crea esta ilusión **virtualizando** la CPU.

Al ejecutar un proceso, detenerlo y luego ejecutar otro, y así sucesivamente, el OS puede promover la ilusión de que existen muchas CPUs virtuales cuando en realidad solo hay una CPU física (o algunas). Esta técnica básica, conocida como compartición de tiempo (time sharing) de la CPU, permite a los usuarios ejecutar tantos procesos concurrentes como deseen; el costo potencial es el rendimiento, ya que cada proceso se ejecutará más lentamente si la(s) CPU(s) deben compartirse.

---
### TIP: Usar time sharing (space sharing)
El tiempo compartido es una tecnica básica usada por un SO para compartir un recurso. Al permitir que el recurso sea usado un ratito por una entidad y luego otro ratito por otra, y así sucesivamente, el recurso en cuestion (por ejemplo, la CPU, o un enlace de una red) puede ser compartido por muchos. La contrapartida del tiempo compartido es el espacio compartido, donde un recurso se divide (en el espacio) entre aquellos que deseen utilizarlo. Por ejemplo, el espacio en disco es naturalmente un recurso de espacio compartido; una vez que se asigna un bloque a un archivo, normalmente no se asigna a otro archivo hasta que el usuario elimina el archivo original.

---

Para implementar la virtualizacion de la CPU, y para implementarla bien, el SO necesitara tanto maquinaria de bajo nivel como inteligencia de alto nivel. A la maquinaria de bajo nivel la llamamos mecanismos; los mecanismos son métodos o protocolos de bajo nivel que implementan una parte de la funcionalidad necesaria. Por ejemplo, mas adelante aprenderemos cómo implementar un  ́cambio de contexto, que le da al SO la capacidad de dejar de ejecutar un pro- grama y empezar a ejecutar otro en una CPU determinada.

Encima de estos mecanismos reside parte de la inteligencia del SO, en forma de políticas. Las políticas son algoritmos para tomar algun tipo de decisión dentro del SO. Por ejemplo, dado un número de programas posibles para ejecutar en una CPU, ¿que programa debería ejecutar el SO? Una política de planificación en el SO tomará esta decision, probablemente utilizando información histórica (por ejemplo, ¿que programa se ha ejecutado más en el ultimo minuto?), conocimiento de la carga de trabajo (por ejemplo, que tipos de programas se ejecutan) y metricas de rendimiento (por ejemplo, ¿el sistema esta optimizando el rendimiento interactivo o el rendimiento de procesamiento?) para tomar su decision.

### La abstracción: Un proceso

Para entender lo que constituye un **proceso**, tenemos que entender su estado: lo que un programa puede leer o actualizar cuando se está ejecutando.

- Un componente obvio del estado que comprende un proceso es su memoria. Las instrucciones se encuentran en la memoria; los datos que el programa en ejecución lee y escribe también se encuentran en la memoria. El proceso puede direccionar la memoria (**espacio de direcciones**).

- Los registros forman parte del estado de un proceso; muchas instrucciones leen o actualizan explícitamente los registros y, por lo tanto, es evidente que son importantes para la ejecución del proceso.

---
### Tip: Separar políticas y mecanismos

En muchos sistemas operativos, un paradigma de diseño común es **separar** las políticas de alto nivel de sus mecanismos de bajo nivel. 
- Se puede pensar en el **mecanismo** como una forma de proporcionar la respuesta del `cómo` sobre un sistema; por ejemplo, ¿cómo realiza un sistema operativo un cambio de contexto? 
- La política proporciona la respuesta del `cuál`; por ejemplo, ¿cuál proceso deber ́ıa ejecutar el sistema operativo en este momento? Separarlos permite cambiar facilmente las políticas sin tener que repensar el mecanismo y, por lo tanto, es una forma de modularidad, un principio general de diseño de software.

---

Registros importantes que forman parte del estado de un proceso:
- **Program Counter**.
- **Stack Pointer**.
- **Frame Pointer**.

Los programas también suelen acceder a dispositivos de almacenamiento persistente.

### La API de los procesos

- Crear: método para crear procesos.
- Destruir: destrucción forzosa de procesos.
- Esperar: A veces es útil esperar a que un proceso deje de ejecutarse, se suele proporcionar algún tipo de interfaz de espera.
- Controles varios: Hay otros tipos de control posibles, entre ellos suspender un proceso para luego reanudarlo, enviar señales a un proceso, etc.
- Estado: Normalmente también hay interfaces para obtener información sobre el estado de un proceso, como el tiempo que lleva en ejecución o el estado en el que se encuentra.

### Creación de procesos: Un poco más detallado

Lo primero que el OS debe hacer para ejecutar un programa es cargar su código y cualquier dato estático (por ejemplo, variables inicializadas) en la memoria, dentro del espacio de direcciones del proceso. Los programas residen inicialmente en el disco (o, en algunos sistemas modernos, en SSDs basados en flash) en algún tipo de formato ejecutable; por lo tanto, el proceso de cargar un programa y datos estáticos en la memoria requiere que el OS lea esos bytes del disco y los coloque en algún lugar de la memoria.

En los primeros (o simples) sistemas operativos, el proceso de carga se realizaba de manera **eager** (apresurada), es decir, todo de una vez antes de ejecutar el programa.

Los sistemas operativos modernos realizan el proceso de forma "lazy" (perezoso), es decir, cargando piezas de código o datos solo cuando son necesarios durante la ejecución del programa.

Para comprender realmente cómo funciona la carga "lazy" de piezas de código y datos, tendrás que entender más sobre los mecanismos de paginación e intercambio (paging and swapping)

Antes de ejecutar cualquier cosa, el OS claramente debe hacer algo de trabajo para llevar los bits importantes del programa desde el disco hasta la memoria.

Una vez que el código y los datos estáticos están cargados en la memoria, hay algunas otras cosas que el OS necesita hacer antes de ejecutar el proceso. Se debe asignar algo de memoria para la pila de ejecución del programa (o simplemente stack).


El OS también puede asignar algo de memoria para el heap del programa. En los programas en C, el heap se utiliza para datos que se solicitan dinámicamente de manera explícita; los programas solicitan dicho espacio llamando a `malloc()` y lo liberan llamando a `free()`. El heap es necesario para estructuras de datos como listas enlazadas, tablas hash, árboles y otras estructuras de datos interesantes. El heap será pequeño al principio; a medida que el programa se ejecuta y solicita más memoria a través de la API de la biblioteca `malloc()`, el OS puede intervenir y asignar más memoria al proceso para ayudar a satisfacer dichas solicitudes.

- El OS también realizará algunas tareas de inicialización adicionales, particularmente relacionadas con la entrada/salida (I/O)


Al cargar el código y los datos estáticos en la memoria, al crear e inicializar una pila y al realizar otras tareas relacionadas con la configuración de I/O, el OS finalmente ha preparado el escenario para la ejecución del programa. Ahora le queda una última tarea: iniciar la ejecución del programa en su punto de entrada, es decir, en `main()`. Al saltar a la rutina `main()`, el OS transfiere el control de la CPU al proceso recién creado, y así el programa comienza.

### Estados de los procesos
Un proceso puede estar en uno de los tres estados:
- **Running (Corriendo)**: Proceso en ejecución en un procesador. Ejecución de instrucciones.
- **Ready (Listo)**: Listo para ejecutarse, pero por algún motivo el SO no ha optado por hacerlo.
- **Blocked (Bloqueado)**: Si un proceso esta bloqueado, ha realizado algÚn tipo de operacion que hace que no este listo para ejecutarse hasta que ocurra algun otro evento.

<br>

<div align="center"><img src="imgs/image.png"></div>

<br>

Pasar de **ready** a **running** significa que un proceso ha sido **scheduled**. Ser movido de **running** a **ready** significa que el proceso va a ser **descheduled**.

Notar que hay muchas decisiones que debe tomar el SO, incluso en este ejemplo simple. Primero, el sistema tuvo que decidir ejecutar Proceso1 mientras Proceso_0 emitía una E/S; hacerlo mejora la utilizacion de los recursos al mantener la CPU ocupada. En segundo lugar, el sistema decidio no volver a cambiar a Proceso_0 cuando se completo su E/S; no está claro si esta es una buena decisión o no.  Este tipo de decisiones las toma el scheduler (planificador) del sistema operativo,

### Estructura de datos

- Nuevo estado, **proceso zombie**: A veces, un sistema tendrá un estado inicial en el que se encuentra el proceso cuando se está creando. Además, un proceso podría ser colocado en un estado final donde ha salido, pero aún no ha sido limpiado. 

Este estado final puede ser útil, ya que permite que otros procesos (generalmente el padre que creó el proceso) examinen el código de retorno del proceso y vean si el proceso recién finalizado se ejecutó con éxito (generalmente, los programas devuelven cero en sistemas basados en UNIX cuando han completado una tarea con éxito, y un valor distinto de cero en caso contrario). Cuando termina, el padre realizará una llamada final (por ejemplo, wait()) para esperar la finalización del hijo y también para indicar al OS que puede limpiar cualquier estructura de datos relevante que hacía referencia al proceso que ahora está extinto.


## Interludio: API de procesos
En este interludio, discutimos la creación de procesos en sistemas UNIX. UNIX presenta una de las formas más intrigantes de crear un nuevo proceso con un par de llamadas al sistema: `fork()` y `exec()`. Una tercera rutina, `wait()`, puede ser utilizada por un proceso que desee esperar a que un proceso que ha creado termine.

> CRUX: Cómo crear y controlar procesos: ¿Qué interfaces debería presentar el OS para la creación y control de procesos? ¿Cómo deberían diseñarse estas interfaces para habilitar una funcionalidad poderosa, facilidad de uso y alto rendimiento?

### fork() System Call
La llamada al sistema fork() se utiliza para crear un nuevo proceso. Sin embargo, debes estar advertido: ciertamente es la rutina más extraña que jamás llamarás. El proceso que se crea es una copia (casi) exacta del proceso que lo llamó. Específicamente, aunque ahora tiene su propia copia del espacio de direcciones (es decir, su propia memoria privada), sus propios registros, su propio PC, etc. Cuando se crea el proceso hijo, ahora hay dos procesos activos en el sistema que nos importan: el padre y el hijo. Suponiendo que estamos ejecutando en un sistema con una sola CPU (por simplicidad), en ese punto podría ejecutarse el hijo o el padre. El planificador de la CPU, un tema que discutiremos con gran detalle pronto, determina qué proceso se ejecuta en un momento dado; dado que el planificador es complejo, generalmente no podemos hacer suposiciones fuertes sobre lo que elegirá hacer, y por lo tanto, qué proceso se ejecutará primero. Este no determinismo, como resulta, conduce a algunos problemas interesantes, particularmente en programas multihilo; por lo tanto, veremos mucho más no determinismo cuando estudiemos concurrencia en la segunda parte del libro.

### The wait() System Call
Hasta ahora, no hemos hecho mucho: solo crear un hijo que imprime un mensaje y sale. A veces, resulta bastante útil que un proceso padre espere a que un proceso hijo termine lo que está haciendo. Esta tarea se logra con la llamada al sistema wait() (o su versión más completa waitpid()) En este ejemplo (p2.c), el proceso padre llama a wait() para retrasar su ejecución hasta que el hijo termine de ejecutarse. Cuando el hijo finaliza, wait() regresa el control al padre. Al agregar una llamada a wait() en el código anterior, la salida se vuelve determinista. Incluso cuando el padre se ejecuta primero, espera educadamente a que el hijo termine de ejecutarse, luego wait() regresa, y entonces el padre imprime su mensaje.

### exec() System Call
una última y crucial pieza de la API de creación de procesos es la llamada al sistema exec(). Esta llamada al sistema es útil cuando quieres ejecutar un programa que es diferente al programa llamante. Por ejemplo, llamar a fork() solo es útil si deseas seguir ejecutando copias del mismo programa. Sin embargo, a menudo deseas ejecutar un programa diferente; exec()

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    printf("hello (pid:%d)\n", (int) getpid());
    int rc = fork();
    if (rc < 0) { // fork falló; salir
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) { // hijo (nuevo proceso)
        printf("child (pid:%d)\n", (int) getpid());
        char *myargs[3];
        myargs[0] = strdup("wc"); // programa: "wc"
        myargs[1] = strdup("p3.c"); // argumento: archivo de entrada
        myargs[2] = NULL; // marcar el final del array
        execvp(myargs[0], myargs); // ejecuta word count
        printf("esto no debería imprimirse");
    } else { // el padre sigue por este camino
        int rc_wait = wait(NULL);
        printf("parent of %d (rc_wait:%d) (pid:%d)\n", rc, rc_wait, (int) getpid());
    }
    return 0;
}
```

La llamada al sistema fork() es extraña; su compañero en el crimen, exec(), tampoco es tan normal. Lo que hace: dado el nombre de un ejecutable (por ejemplo, wc), y algunos argumentos (por ejemplo, p3.c), carga el código (y datos estáticos) de ese ejecutable y sobrescribe su segmento de código actual (y datos estáticos actuales) con él; el heap, la pila y otras partes del espacio de memoria del programa se re-inicializan. Luego, el sistema operativo simplemente ejecuta ese programa, pasando cualquier argumento como el argv de ese proceso. Así, no crea un nuevo proceso; más bien, transforma el programa que se está ejecutando (anteriormente p3) en un programa diferente (wc). Después de exec() en el hijo, es casi como si p3.c nunca se hubiera ejecutado; una llamada exitosa a exec() nunca regresa.

### ¿Por qué? Motivando a la API
Por supuesto, una gran pregunta que podrías tener es: ¿por qué construir una interfaz tan extraña para lo que debería ser el acto simple de crear un nuevo proceso? Bueno, resulta que la separación de fork() y exec() es esencial para construir un shell en UNIX, porque permite que el shell ejecute código después de la llamada a fork() pero antes de la llamada a exec(). Este código puede alterar el entorno del programa que está a punto de ejecutarse, lo que permite construir fácilmente una variedad de características interesantes.

El shell es solo un programa de usuario. Te muestra un prompt y luego espera que escribas algo en él. Luego escribes un comando (es decir, el nombre de un programa ejecutable, más cualquier argumento); en la mayoría de los casos, el shell averigua dónde se encuentra el ejecutable en el sistema de archivos, llama a fork() para crear un nuevo proceso hijo que ejecute el comando, llama a alguna variante de exec() para ejecutar el comando, y luego espera a que el comando termine llamando a wait(). Cuando el hijo termina, el shell regresa de wait() y vuelve a imprimir un prompt, listo para tu próximo comando.

La separación de fork() y exec() permite al shell hacer un montón de cosas útiles con relativa facilidad. Por ejemplo:
```shell
wc p3.c > newfile.txt
```
En el ejemplo anterior, la salida del programa wc se redirige al archivo de salida newfile.txt (el signo mayor que indica dicha redirección). La forma en que el shell logra esta tarea es bastante simple: cuando se crea el hijo, antes de llamar a exec(), el shell (específicamente, el código ejecutado en el proceso hijo) cierra la salida estándar y abre el archivo newfile.txt. Al hacer esto, cualquier salida del programa que está a punto de ejecutarse, wc, se envía al archivo en lugar de a la pantalla (los descriptores de archivos abiertos se mantienen abiertos a través de la llamada a exec(), lo que permite este comportamiento).

La Figura 5.4 muestra un programa que hace exactamente esto. La razón por la que esta redirección funciona se debe a una suposición sobre cómo el sistema operativo gestiona los descriptores de archivos. Específicamente, los sistemas UNIX comienzan a buscar descriptores de archivos libres desde cero. En este caso, STDOUT_FILENO será el primero disponible y, por lo tanto, se asignará cuando se llame a open(). Las escrituras subsecuentes del proceso hijo al descriptor de archivo de salida estándar, por ejemplo, mediante rutinas como printf(), se dirigirán automáticamente al archivo recién abierto en lugar de a la pantalla.

Notarás (al menos) dos detalles interesantes sobre esta salida. Primero, cuando se ejecuta p4, parece que no ha sucedido nada; el shell simplemente imprime el prompt de comando y está inmediatamente listo para tu próximo comando. Sin embargo, ese no es el caso; el programa p4 realmente llamó a fork() para crear un nuevo hijo y luego ejecutó el programa wc mediante una llamada a execvp(). No ves ninguna salida en la pantalla porque se ha redirigido al archivo p4.output. Segundo, puedes ver que cuando usamos cat para ver el archivo de salida, se encuentra toda la salida esperada de la ejecución de wc.

Por ahora, basta con decir que la combinación de fork()/exec() es una manera poderosa de crear y manipular procesos.

### Process Control and Users
Más allá de fork(), exec() y wait(), existen muchas otras interfaces para interactuar con procesos en sistemas UNIX. Por ejemplo, la llamada al sistema kill() se utiliza para enviar señales a un proceso, incluyendo directivas para pausar, finalizar, y otras órdenes útiles. Para mayor comodidad, en la mayoría de los shells de UNIX, ciertas combinaciones de teclas están configuradas para enviar una señal específica al proceso que se está ejecutando; por ejemplo, control-c envía un SIGINT (interrupción) al proceso (normalmente terminándolo), y control-z envía una señal SIGTSTP (stop), pausando así el proceso en mitad de su ejecución (puedes reanudarlo más tarde con un comando, por ejemplo, el comando fg que se encuentra en muchos shells). Todo el subsistema de señales proporciona una infraestructura rica para entregar eventos externos a procesos, incluyendo formas de recibir y procesar esas señales dentro de procesos individuales, así como formas de enviar señales a procesos individuales o a grupos enteros de procesos.

Para utilizar esta forma de comunicación, un proceso debe usar la llamada al sistema signal() para "capturar" varias señales; al hacerlo, se asegura de que cuando una señal particular se entregue a un proceso, este suspenderá su ejecución normal y ejecutará una porción específica de código en respuesta a la señal. Puedes leer en otra parte [SR05] para aprender más sobre las señales y sus múltiples complejidades.

Esto naturalmente plantea la pregunta: ¿quién puede enviar una señal a un proceso y quién no? Generalmente, los sistemas que usamos pueden ser utilizados por múltiples personas al mismo tiempo; si una de estas personas pudiera enviar arbitrariamente señales como SIGINT (para interrumpir un proceso, probablemente terminándolo), la usabilidad y seguridad del sistema se verían comprometidas. Como resultado, los sistemas modernos incluyen una concepción sólida de la noción de un usuario.
 * El usuario, después de ingresar una contraseña para establecer credenciales, inicia sesión para obtener acceso a los recursos del sistema.
 * El usuario puede entonces lanzar uno o muchos procesos y ejercer control total sobre ellos (pausarlos, matarlos, etc.).
 * Los usuarios generalmente solo pueden controlar sus propios procesos; es el trabajo del sistema operativo distribuir los recursos (como CPU, memoria y disco) a cada usuario (y sus procesos) para cumplir con los objetivos generales del sistema.

### Herramientas útiles
Existen muchas herramientas de línea de comandos que también son útiles. Por ejemplo, el comando ps te permite ver qué procesos están en ejecución; consulta las páginas de manual para obtener algunas banderas útiles que puedes pasar a ps. La herramienta top también es bastante útil, ya que muestra los procesos del sistema y cuántos recursos de CPU y otros están consumiendo. Curiosamente, muchas veces cuando ejecutas top, este afirma ser el que más recursos consume; quizás es un poco egocéntrico. El comando kill se puede usar para enviar señales arbitrarias a los procesos, al igual que el comando killall, que es un poco más amigable para el usuario. Asegúrate de usarlos con cuidado; si accidentalmente matas tu gestor de ventanas, la computadora frente a ti puede volverse bastante difícil de usar.

Finalmente, hay muchos tipos diferentes de medidores de CPU que puedes usar para obtener una comprensión rápida de la carga en tu sistema; por ejemplo, siempre mantenemos MenuMeters (de Raging Menace Software) funcionando en nuestras barras de herramientas de Macintosh, para que podamos ver cuánto CPU se está utilizando en cualquier momento. En general, cuanta más información tengas sobre lo que está sucediendo, mejor.

### Aside: El superusuario (ROOT)
Un sistema generalmente necesita un usuario que pueda administrar el sistema y que no esté limitado de la misma manera que la mayoría de los usuarios. Dicho usuario debería poder matar un proceso arbitrario (por ejemplo, si está abusando del sistema de alguna manera), aunque ese proceso no haya sido iniciado por este usuario. Tal usuario también debería poder ejecutar comandos poderosos como shutdown (que, como es de esperarse, apaga el sistema). En los sistemas basados en UNIX, estas habilidades especiales se otorgan al superusuario (a veces llamado root). Mientras que la mayoría de los usuarios no pueden matar los procesos de otros usuarios, el superusuario sí puede. Ser root es como ser Spider-Man: con un gran poder viene una gran responsabilidad. Por lo tanto, para aumentar la seguridad (y evitar errores costosos), generalmente es mejor ser un usuario regular; si necesitas ser root, procede con cautela, ya que todos los poderes destructivos del mundo de la computación están ahora a tu alcance.
# Laboratorio 0: 🐚 Shell Scripting 🐚
Primer laboratorio de Sistemas Operativos.

<p style="font-size:20px">
<a href="https://docs.google.com/document/d/1Vp1U3n7E9ikn239sKlzJ_Oxir6YVZ8LVgHVdoZ45izs/edit?pli=1">Link al enunciado del laboratorio.</a>
</p>

Se pide investigar por nuestra cuenta el funcionamiento de los distintos **comandos** como:

- grep
- cat
- sort
- head

**Conectores** como:
- **&** (ampersand)
- **|** (pipes)
- **><** (redirecciones)
---

### Recursos útiles
[Machete lindo proporcionado por la cátedra](https://drive.google.com/file/d/1QFROtJe_TtXnQqAf656BFQgQ8AyyYwpC/view)

[Machete no tan lindo pero útil proporcionado por la cátedra](https://explainshell.com/)

---

## Entrega

La resolución de este práctico es individual. Deben entregar un archivo .sh a través del aula virtual, con un comando de una línea por cada ejercicio. El práctico no se evalúa con nota, pero debe estar aprobado para poder promocionar o regularizar la materia.

### Archivo con extensión .sh
He investigado que los archivos con extensión .sh son scripts de shell, es decir, scripts de comandos de shell.

<p align="center" style="font-size:20px">
<a href="https://docs.fileformat.com/es/programming/sh/">Información sobre los archivos SH</a>
</p>

**Crear un archivo:**
- Primero debo situarme en la carpeta donde quiero que se guarde el archivo.
- Luego, debo abrir la terminal y escribir el comando `nano nombre_archivo.sh` (reemplazando `nombre_archivo` por el nombre que quiero que tenga el archivo y obviamente tener nano instalado).
- Una vez dentro del editor de texto, debo escribir los comandos de una línea por cada ejercicio pero antes tener en cuenta de dejar como primera línea la almohadilla:
`#!/bin/bash`.
- Para guardar el archivo, debo presionar `Ctrl + O` y luego `Enter`.
- Para salir del editor de texto, debo presionar `Ctrl + X.
- Por último, debo darle **permisos de ejecución** al archivo con el comando `chmod 777 nombre_archivo.sh`
- Luego para ejecutar el script debo escribir: `./nombre_archivo.sh`

## Ejercicios
1) ¿Qué modelo de procesador tiene tu equipo?

    Cuando necesitamos un dato del equipo, como por ejemplo el modelo del procesador, podemos buscar en el archivo /proc/cpuinfo. Sin embargo, este comando nos devuelve un listado muy largo y tienen que encontrar la forma de buscar sólo la información necesaria. 
    
    >Ayuda: ver la definición y el uso de los comandos cat y grep.

    ### Definición y usos de los comandos **cat** y **grep**
    - **cat**: Concatena archivos y los imprime en la salida estándar.
        ```bash
            > cat [opciones] [archivo]
        ```
    - **grep**: Filtra líneas de texto que coincidan con un patrón.
        ```bash 
            > grep [opciones] [patrón] [archivo]
        ```
        En particular si utilizamos la opción `-m1` nos devolverá la primera coincidencia.
<br>

2) Si la computadora tiene más de una unidad de ejecución (multi-core) seguramente en el punto anterior se repitió más de una vez el modelo del procesador. Averiguar cómo usar wc para poder determinar cuántas unidades de ejecución tiene el procesador, aprovechando los comandos utilizados en el ejercicio 1.

    ### Uso del comando **wc**

    ```bash
        > wc [opciones] [archivo]
    ```

    **-l**: Cuenta las líneas.
    
    **-w**: Cuenta las palabras.

    **'NF'**: Imprime solo las líneas donde `NF` es `True`, es decir, sólo donde el número de campos sea mayor a 0.


<br>

3) Usted tiene la maravillosa idea de crear una red social para superhéroes donde puedan interactuar sin máscaras y con sus nombres verdaderos (todo financiado por Bruce Wayne o Tony Stark, dependiendo del estudio). Para la semana de lanzamiento, le enviará una invitación personalizada a cada superhéroe. Su base de datos es el siguiente archivo [heroes.csv](https://raw.githubusercontent.com/dariomalchiodi/superhero-datascience/master/content/data/heroes.csv).  Notar que la segunda columna contiene el nombre real de cada superhéroe, pero los usuarios en su sistema deben estar todos en minúsculas y sin espacios. 

    ¿Cómo obtendría esta lista de nombres de usuarios con un único comando bash? Incluso la descarga del archivo. Puntos extra si eliminan las líneas en blanco del resultado.
    > Ayuda: dividir el problema en varias subpartes: descargar archivo, separar la columna deseada, modificar texto, etc. Los comandos de bash pueden ponerse en una misma línea utilizando conectores adecuados, que tienen distinta semántica.

    En principio utilizando la ayuda (Divide y vencerás) podemos hacer lo siguiente:

    ### Uso del comando **wget (Descargar archivo)**

    ```bash
        > wget [opciones] [URL]
    ```
    **-O**: Guarda el archivo con el nombre que le indiquemos (En particular crea un archivo).
    ```bash
        > wget -O [nombre_archivo] [URL]
    ```
    ### Uso del comando **curl** (Parsea el archivo desde la URL)
    ```bash
        > curl [opciones] [URL]
    ```


    ### Uso del comando **awk (Separar la columna deseada)**

    ```bash
        > awk [opciones] [archivo]
    ```
    **-F**: Define el separador de campos.
    ```bash
        > awk -F "," '{print $2}' [archivo]
    ```

    > Tener en cuenta que cuando abrimos {} (llaves) nos situamos en un entorno de programación secuencial de awk, es decir, podemos realizar operaciones con los campos que se nos presentan como por ejemplo printear el campo 2.

    ### Uso del comando tr (Modificar texto)

    ```bash
        > tr [opciones] [caracter_a_reemplazar] [caracter_reemplazo]
    ```

    > Tener en cuenta que en este comando tenemos que el primer arreglo son los caracteres a reemplazar y el segundo arreglo es el caracter de reemplazo.

<br>

4) El archivo weather_cordoba.in contiene mediciones meteorológicas realizadas en un día en Córdoba. Las primeras 3 columnas corresponden al año, mes y día de las mediciones. Las restantes 6 columnas son la temperatura media, la máxima, la mínima, la presión atmosférica, la humedad y las precipitaciones medidas ese día. Objetivo: Calcular el día de máxima temperatura (máximo de máximas) y el día de mínima temperatura (mínimo de mínimas). Idea para facilitar la tarea: Ordenar los días según su temperatura máxima. Puntos extra por mostrar en la pantalla sólo la fecha de dichos días (un comando para cada día). Tengan en cuenta que para evitar los números reales, los grados están expresados en décimas de grados (por ejemplo, 15.2 grados está representado por 152 décimas). La presión también ha sido multiplicada por 10 y las precipitaciones por 100, o sea que están expresadas en centésimas de milímetro.

<br>

5) El archivo atpplayers.in es un listado por orden alfabético de jugadores profesionales de tenis. El nombre del jugador viene acompañado de una abreviatura de su país, el número que ocupa en el ranking, su edad, su puntaje y el número de torneos jugados en el último año. Ordenar el listado de jugadores según la posición en el ranking.

<br>

6) El archivo superliga.in contiene datos con el siguiente formato: nombre de equipo sin espacios, puntos, partidos jugados, partidos ganados, partidos empatados, partidos perdidos, goles a favor y goles en contra. Ordenar la tabla del campeonato de la Superliga según la cantidad de puntos, y desempatar por diferencia de goles. Ayuda: a todo lo que ya saben del ejercicio anterior, agreguen el uso del comando awk.

<br>

7) ¿Cómo ver la MAC address de nuestro equipo? Investiguen el comando ip. En el manual de grep van a encontrar la especificación de muchas operaciones, por ejemplo -o, -i, y muchas más. Algo muy utilizado son las expresiones regulares para realizar una búsqueda. En el manual de grep tienen un apartado donde explica su uso. Con esta información deberían poder construir una secuencia de comandos de shell para imprimir por consola la MAC address de su interfaz ethernet.

#### ¿Qué es una MAC Address?
La MAC Address (Media Access Control Address) es un identificador único asignado a la tarjeta de red de tu dispositivo. Es una dirección física que consta de 48 bits y suele representarse en formato hexadecimal (por ejemplo, 00:1A:2B:3C:4D:5E). Cada dispositivo de red, como una tarjeta Ethernet o Wi-Fi, tiene una MAC address única que es utilizada para la comunicación en redes locales.

#### ¿Qué es la interfaz Ethernet?
La interfaz Ethernet es el hardware que permite la conexión a una red local (LAN) mediante un cable Ethernet. Cada interfaz Ethernet tiene una MAC Address asociada, que se utiliza para identificar el dispositivo en la red.

#### ¿Qué es el comando ip?
El comando ip es una herramienta poderosa en Linux que se usa para mostrar y manipular las configuraciones de red en tu sistema. Puedes usarlo para ver información sobre interfaces de red, rutas, direcciones IP, y más.

<br>

8) Supongamos que bajaron una serie de televisión completa con subtítulos (de forma completamente legal, por supuesto). Sin embargo, los subtítulos tienen el sufijo _es en el nombre de cada archivo y para que puedan ser reproducidos en el televisor, que nunca fue demasiado smart, el archivo de subtítulos tiene que tener exactamente el mismo nombre que el archivo de video con la extensión srt. La serie tiene más de 100 capítulos, es imposible realizar los cambios uno a uno.

    1. Para emular la situación, crear una carpeta con el nombre de la serie y dentro de ella crear 10 archivos con un nombre como fma_S01EXX_es.srt, donde XX es el número de capítulo, desde 1 hasta 10.
   
    2. Con un segundo comando (el que usarían realmente), cambiar el nombre de cada archivo sacando el sufijo _es.

> Ayuda: Usar un ciclo for. Se pueden hacer ciclos en una única línea. Puntos extra si los archivos de video no siguen un patrón, sino que pueden llamarse de cualquier forma.

<br>

9) **[OPCIONAL]** El comando ffmpeg sirve para editar streams de video y audio desde la consola, de forma muchísimo más rápida que otros editores de video. Tienen que descubrir cómo realizar las siguientes tareas:
    
    1. Recortar un video. Pueden usar SimpleScreenRecorder (linux) para grabar un pequeño video de prueba. Luego, usen ffmpeg para sacarle los primeros y los últimos segundos en donde se ve el la pantalla como inician y cortan la grabación.

    2. Mezclar streams de audio. Graben un pequeño audio de voz, y descarguen de internet alguna pista de sonido que quieran poner de fondo. Usen ffmpeg para superponer las dos pistas. Tomen como ejemplo los podcasts de Nico!





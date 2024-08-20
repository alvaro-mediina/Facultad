# Ingeniería del Software I


<p align="center"><img alt="Static Badge" src="https://img.shields.io/badge/LIVE-27ae60?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/PRETTY-%238e44ad?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/respect-%23e74c3c?style=for-the-badge">

</p>

En este documento dejaré escrito todo el contenido de la materia, desde teoría, sección de laboratorio, libros,podcast, sugerencias entre otros.

## Indice
* [Información principal de la materia](#información-principal-de-la-materia)
* [Bibliografía](#bibliografía)
* [Teórico](Resumen.md)
* [Prácticos](https://drive.google.com/drive/folders/14C9eILG6zNPhYipBI9z_8SBe50iJTXCG?usp=sharing)
  - [Práctico 1](https://docs.google.com/document/d/1C6W_nufv8FbT3c3O4J7KEj57NOGdsmMtjrCqyOhrDfc/edit?usp=sharing)
  - [Práctico 2](https://docs.google.com/document/d/1Wv4i-r32ecbHBLn_eIJP1ADHPT6jvH0PxpIJnSuhw0g/edit?usp=sharing)
* [Laboratorio](#laboratorio)

## Información principal de la materia

<p align="left" style="font-size:15px;">Clases: <strong style="font-size:15px; color: yellow;">Martes y Jueves de 9AM a 13PM (4 horas en total)</strong></p>

<p align="left" style="font-size:15px;">Profesora: <strong style="font-size:15px; color:yellow;">Laura Brandán Briones</strong></p>

<p align="left" style="font-size:15px;">Profesores: <strong style="font-size:15px; color:yellow;">Santiago Ávalos - Julio Bianco - Matías Lee - Diego Lis - Gonzalo Peralta - Leandro Ramos</strong></p>

<p align="left" style="font-size:15px;">Ayudantes: <strong style="font-size:15px; color:yellow;">Bruno Castellano y Sara Kim</strong></p>

<p align="left" style="font-size:15px;">Aula: <strong style="font-size:15px; color:yellow;">Pabellón de la Reforma, R6.</strong></p>


<p align="left" style="font-size:15px;">Modalidad: <strong style="font-size:15px; color:yellow;">Presencial</strong></p>

<p align="left" style="font-size:15px;">Carga horaria: <strong style="font-size:15px; color:yellow;">8 horas semanales</strong></p>

<p align="left" style="font-size:15px;">Parciales:<ul>
        <li>Primer Parcial: <strong style="font-size:15px; color:yellow;">26 de septiembre</strong></li>
        <li>Segundo Parcial: <strong style="font-size:15px; color:yellow;">31 de Octubre.</strong></li>
        <li>Recuperatorio (Sirve para promocionar): <strong style="font-size:15px; color:yellow;">14 de Noviembre</strong></li>
        </ul>
</p>

$$
\text{Nota} = \frac{(P1 + P2 + PR)}{3}
$$

$$
\text{Donde claramente} \quad
\begin{cases}
P1 := \text{Primer Parcial}\\
P2 := \text{Segundo Parcial}\\
PR := \text{Proyecto}
\end{cases}
$$

### Metodología

Recomendaciones: 
- Aprobar el Take Home (Se puede elegir grupo)
- No dejar de interactuar con los profesores.
- Para el parcial NO utilizar una palabra para definir una palabra.
- Utilizar verbos en presente y ser lo más básico para hablar en el sentido de que se entienda pero no dejar la tecnicidad.
- En **diseño**, intentar que nuestro producto sea lo más accesible posible.


A tener en cuenta:
- No se puede seguir con e proyecto si te quedás libre en el teórico.
- El tiempo vale oro.

### Preguntas Parcial

#### Dominio del problema

 - Desafios de la IS: Tener en cuenta las 5 palabras claves. 

 - En escala así como puede subir, también puede bajar.

 - ¿Por qué los procesos están divididos en fases? Nombrar las fases típicas: Testing, etc.

#### SRS
 - Nombrar las actividades básicas de los requerimientos del software: Análisis del problema o requerimientos, Especificación de los requerimientos y Validación.

#### Análisis del problema
 - Cuáles son los pasos principales para armar un DFD.

#### Especificación de los requerimientos
- Qué es una SRS.
- Características de una SRS.

### Punto función
- ¿Para que sirve? 
- ¿Que es?
- ¿Cual es su entrada?
- ¿Cual su salida?

### Estilos
Saber los 6 estilos y sus restricciones.

## Laboratorio: El switcher

- Día de entrega de TH: 29 de agosto de 2024, hasta antes de las 23:55 hs.


**Alcance del proyecto**: Desde lo general a lo particular.

- Se puede itemizar el alcance, pero no debería serlo de forma totalitaria.

- El alcance suele ser algo corto.

- Que cosas entran: lo que está dentro del proyecto
- Que no entra: No un listado que no hace falta, sino que cosas tendremos en cuenta para el proyecto.

EL ALCANCE LO ES TODO.

**DFD**: Completo

**Diagrama de clases**: Se pide el diagrama de clases completo del proyecto.

**Casos de uso a entregar**:
- Crear partida.
- Turno completo.
- Bloqueo y desbloqueo de figura.

Estas cosas que se están pidiendo son distintas vistas del proyecto, se tienen que correlacionar. 

**Reglas del juego**:
- Jugadores: de 2 a 4.
- Se hace una distribución aleatoria de todos las tarjetas de colores en el tablero.
- Hay 4 colores de tarjetas.
- A cada jugador se le reparten fichas con formas y colores de fondo distinto. (Las que tienen fondo blanco dificiles; fondo azul fáciles)
- No podemos ver el mazo repartido de las fichas.
- Inicialmente, tenemos 3 cartas con indicaciones (fichas de movimiento) que se deben cumplir (cruces):
    - Primero movimiento: Swapeo. Se puede cambiar el sentido para el swapeo tanto vertical como horizontal.
    - Segundo movimiento: Swapeo en L. Se puede cambiar el sentido para el swapeo tanto vertical como horizontal.
- Tenemos colores bloqueados (Las tarjetas de colores se pueden bloquear).

<br>

- Cuando un jugador inicia su turno da vuelta 3 de sus cartas.
- Sólo se pueden dar vueltas 3 cartas a la vez
- Objetivo: Descartar todo el mazo personal.
- Cada jugador tiene un tiempo límite. No hay límite de turnos pero hay límite de tiempo.

<br>

### Reglas del juego

- La idea es formar las figuras que están en las tarjetas de colores.
- No se pueden utilizar cartas de movimiento y no formar alguna figura. En el caso de no formar la figura, se vuelve al estado inicial antes de mover las fichas.
- No se puede jugar tablero pacman.

- La figura debe ser exacta, no puede tener ni de más ni de menos fichas.
- Un color se bloquea cuando formo una figura con ese color. Es bloqueado para todos los jugadores.
- En el caso de formar dos colores se debe elegir un color para bloquear. Y se pausa el otro color

- Cuando el juego inicia no hay colores prohibidos.

- Cuando realizo movimientos y al final no tiene sentido lo que hice, vuelvo al estado inicial. Es como: 0- 1 --- 2 --- 3 --- NOTHING => 0

- Algo que se debe chequear siempre es el color válido para considerar que se armó la figura.

- Se sortea el primer jugador.

- El turno se termina o bien cuando termina el tiempo o bien cuando utilizo mis 3 cartas de movimientos.

- Cada vez que empieza mi turno, se me reponen hasta completar las 3. Si no las he utilizado en el turno anterior se mantienen.

- No se pueden mover las fichas para para romper el tablero de alguien más.

- Armar una figura es un procedimiento en el cual es válido mediante una secuencia. Como por ejemplo 1---2---3---4 todas las secuencias llevaron  a la figura por ende son válidas.

- Puedo saltear mi turno.

- El turno siempre se tiene 3 cartas de movimiento y 3 de figura.

- Las cartas de movimiento son infinitas.

- Si tenemos todos la misma figura, el jugador que la construya puede bloquearsela a un jugador. Un jugador puede tener una carta bloqueada por vez.

- Si me queda una carta sola para formar, no me pueden bloquear.

- Se puede bloquear si y sólo si tengo al menos 2 cartas.

- Si estoy bloqueado no me puedo reponer figuras hasta que elimine todas las que están disponibles. Una vez elimino las figuras disponibles se habilita la bloqueada y luego de formar la bloqueada se reponen más.

- El color prohibido se convierte en la ficha que formaste.

- Tiene que haber un chat para interactuar.

- Formar figuras tiene acciones: bloqueo o descartar la carta.

- Hay un mazo de descarte de movimiento y de figuras.

- Se reparten todas las cartas de jugadores (En el juego son 9 y 9) pero teniendo en cuenta que sea equitativo en el sentido de X cantidad de azules y blancas.

- El juego acaba con 1 ganador.
- El puntaje es restar la cantidad de figuras a medida que se van formando.

- 2 MINUTOS por turno.

- Al formar una figura se debe indicar una acción: BLOQUEAR O DESCARTAR.

- Las cartas se reponen al terminar el turno.

### Pedido del owner

- El orden de TODOS los jugadores se sortea.

- Poder jugar al switcher a través de la web con otros jugadores. Es decir poder jugarlo online.

- Que algún jugador pueda crear partidas y que otros jugadores puedan unirse.

- Gana el juego el que se queda sin figuras a armar.

- Salas de partidas.

- Para entrar a una sala necesito un nombre de usuario.




## Bibliografía

- **Pakaj Jalote: “An Integrated Approach to Software Engineering”, 3ra ed., Springer**
- Oportunamente se brindará material adicional.

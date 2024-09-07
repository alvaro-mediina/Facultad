<br>
<p align="center" style="font-size:30px"><strong>🔧 Práctico de AdC 🔧
</strong></p>

---

<br>

# Versión importante
==EP4CE22F17C6==
---

# Field Programmable Gate Arrays(FPGAs)

Nos permite implementar circuitos digitales y nos permite reconfigurarlo. Es en dónde vamos a implementar el micro.

FPGAs: Arreglos de compuertas programables en campo.

Son circuitos integrados digitales que contienen bloques lógicos programables junto con un interconexiones entre dichos bloques. Es parecido a una PLA pero con la diferencia de que los bloques lógicos son programables.

- **ASIC**: Circuito integrado de aplicación específica. Son "hechos a medida". Son más rápidos que las FPGA, consumen menos energía y son fabricados en gran escala, son más baratos.

- **FPGA**: Circuito integrado programable. No son hechas a medida, por lo que el usuario puede configurarlas de acuerdo a sus necesidades.

### FPGA: Elementos básicos
Una FPGA tiene adentro:
- Elementos lógicos
- Recursos de memoria
- I/O configurables: puertos.
- Recursos de ruteo: posibilidad de conexionado (el secreto de las FPGA).
- Recursos adicionales

![alt text](imgs/image-7.png)

### FPGA: Elementos lógicos(LUT)
La función lógica se almacena en una tabla de verdad 16x1 (para las LUTs de 4 entradas). La columna de valores de salida de la función combinacional son los valores que realmente se almacenan en la LUT.

![alt text](imgs/image-8.png)
<p style="text-align: center;"><em>El resultado se llama bitstream</em></p>

### FPGA: Utilización del Roteo

![alt text](imgs/image-9.png)

### Flujo de diseño
![alt text](imgs/image-10.png)

- Design Entry: Se puede hacer en HDL o en un lenguaje de descripción de hardware.

- Synthesis: Se traduce el código HDL a un netlist. Tarda mucho más que una compilación de un código. Conbierte en un combinacional.

- Place & Route: Se ubican los elementos lógicos y se hace el ruteo. Se puede hacer de manera automática o manual.

- Timing Analysis: Se verifica que el circuito cumpla con los tiempos de propagación.

- Simulation: Se simula el circuito.

- Programming & Configuration: Se programa la FPGA.

![alt text](imgs/image-11.png)
<p style="text-align: center;"><em>Compilación del circuito</em></p>


## Behavioral SystemVerilog
> Siempre un módulo por archivo y tener el nombre del módulo = al nombre del archivo.

#  Introducción a System Verilog
## Módulos parametrizados
* Los parámetros se definen de la siguiente forma:
```verilog
#(parameter variable = valor)
```
* Uso por defecto con un bus de 8 bits sin parametrización:
```verilog
mux2 myMux(d0,d1,s,out);
```

* Uso con un bus de 12 bits con parametrización:
```verilog
mux2 #(12) lowmux(d0,d1,s,out);
```

## Arreglos
Difieren en la forma de acceder a los elementos del arreglo.

Los arreglos empaquetados primero tengo que acceder al sector del paquete y luego al elemento del paquete.

Los arreglos no empaquetados se accede directamente al elemento.

Para definir un arreglo empaquetado debo escribir en la sintaxis el nombre al final.

* A la hora de cargar un arreglo no empaquetado se puede decidir el orden de la carga de datos:

    `logic [7:0] table[0:3]`

  Podemos modificar el orden en `table`

* A la hora de acceder a un arreglo debemos tener en cuenta la declaración, ya que su sintaxis es: 
* `logic` [cantidad de bits:fin cantidad de bits] nombre [fin de elementos: inicio]
Por ende para acceder al bit 0 del elemento 1 utilizamos: `nombre[0][1]`

## Test bench
Tipos:
 * Simples.
 * Self-checking.
 * Self-checking with test vectors: Tener entradas predefinidas en un arreglo para testear.

Tener en cuenta las palabras reservadas como always, always_ff, initial, etc. Funcionan de forma concurrente. 

En los test simples definimos todo de forma manual.

Cuando definamos una unidad de tiempo, esta no puede ser menor a 1 valor de alguna Unidad de medida determinada en el simulador SIEMPRE y cuando no lo nombremos ya que podemos tener el siguiente caso.

```verilog
#10ns; //Al simulador no le va a importar la unidad de tiempo por default
#1000; //Considera la unidad de tiempo del simulador.
```
* El símbolo "!==" es distinto.
* El símbolo "===" es estrictamente igual.

```verilog
logic [3:0] testvectors [7:0] = '{
    4'b000_0, 4'b000_1, 4'b001_0, 4'b001_1,
    4'b010_0, 4'b010_1, 4'b011_0, 4'b011_1
};
//Al _ lo utilizo para señalar cual es la salida esperada.
```

# Repaso a Leg v8
Recordar que se utilizarán registros de 64 bits.

# Sistemas de entrada y salida
Los sistemas de I/O hoy por hoy se conectan a los mismos sistema de memoria. Antes teníamos un sistema de I/O separado, por ejemplo  ==antes== teníamos un bus de direccionado y un bus de datos.

En la jerga yanqui los periféricos son los componentes fuera del procesador, en este caso periféricos son los artefactos de entrada salida como teclado, mouse, etc. Se referirá a `módulo de entrada/salida` como el módulo que se encarga de la `comunicación` entre el procesador y los periféricos.

- No hay módulos de I/O pegados al procesador.

- Los periféricos se conectan al sistema de memoria a través de interfaces ya que son muy lentos a comparación de la velocidad que puede llegar a manipular el cpu.


## Tipos de buses basados en I/O
- Se tiene un estándar de I/O (I/O que mapea un I/O). Tal estándar es un par de memorias controladas por un chip select, tal que el chip select activa el mapa de memoria de datos o de I/O. Estos dos mapas tienen dos mapas igual capacidad de direccionamiento (Tipo de Arquitectura que utiliza Intel, Arquitectura RISK utilizan sólo un espacio de memoria para ambos mapas).

> Recordar que si tenemos un direccionado de $2^N$ direcciones, tenemos $N$ bits de dirección, si agregamos un bit más de dirección tenemos $2^{N+1}$ direcciones.

Tenemos que la memoria de I/O es un "manejador" del hardware que se corresponderá con la memoria.

## Memory-mapped I/O vs Standard I/O
- Memory-mapped I/O: 
  - No requiere instrucciones especiales

- Standard I/O: 
  - No les importa complejizar la ISA.
  - No se pierde direccionado de memoria para los periféricos.

## I/O Operation Methods
- Polling-driven (I/O programada): Están escritos en programas.
- Interrupt-driven: Interrupciones.
- Direct Memory Access (DMA - Método actual)

### Polling-driven
El manejo se realiza mediante el uso de instrucciones de I/O por código de programa (if's, else's, bucles, etc)

### Interrupt-driven
Es un recurso de HW propio de la CPU: señal de **Int** externa para periféricos. Es literalmente una "interrupción" o quiebre de la ejecución de la ejecución normal del código de programa. Es asíncrona

Cuando se produce una interrupción, el CPU debe verificar automáticamente si hay Int's pendientes. De esta forma el "polling" lo realiza la CPU por HW: **no consue ciclos de instrucción**. Si hay **Int**, el CPU salta automáticamente a una posición de memoria específica llamada **vector de insterrupciones**. El vector de interrupciones contiene el código (o su referencia) con los procedimientos necesarios para dar servicio a dicha interripción. Este código se denomina ISR (Interrupt Service Routine).

#### ¿Dónde se aloja la ISR?
- Se encuentra en una **dirección fija** (Fixed interrupt).
- La dirección está establecida en la lógica de la CPU, no puede ser modificada.
- La CPU puede contener la dirección real, o contener una instrucción de salto a la dirección real de la ISR sino hay suficiente espacio reservado.

- Por otro lado se encuentra en una **dirección vectorizada** 


### Sistemas de I/O
Internamente formados por:
- Registro de datos.
- Registro de estado/control.
- Lógica de interfaz con el dispositivo externo.
- Lógica de I/O.
- Lógica de interfaz con el dispositivo externo.

### Consideraciones adicionales

**Interrupciones Enmascarables vs No enmascarables**
- Enmascarables: El programador puede mofificar un bit que causa que el procesador ignore una solicitud de interrupción (GEI)
  - Muy importante para usar cuando se tienen porciones de códigos temporalmente críticas.
- No enmacarables: 
- Salto a una ISR:

### Múltiples periféricos: Arbitraje
Considere la situación donde muchos periféricos solicitan el servicio de una CPU simultáneamente (microcontrolador)  **Cual será atendida primero y en qué orden?**

- Software Polling:
  - Muy simple implementación por HW.
  - El programador debe determinar en la ISR el origen de la INT buscando banderas INT FLG.
  - La prioridad es establecida en la ISR según el órden de la búsqueda.
- Arbitro de prioridades. (Priority arbiter): Es un módulo que recibe la señal de interrupción de distintos periféricos.
- Conexión en cadena. (Daisy Chain)
- Arbitraje de bus. (Network-oriented)
  - Utilizado en arquitecturas de múltiples procesadores.
  - El periférico debe primero obtener la sesión del bus para luego requerir una interrupción.

### Excepciones e Interrupciones
El mecanismo es el mismo pero no todas las excepciones son interrupciones ya que cuando se produce un evento de I/O se levanta una excepción pero no cuando se produce una excepción necesariamente es una interrupción.
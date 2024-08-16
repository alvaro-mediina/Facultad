# Teórico
Aprenderemos en detalle el funcionamiento interno y el incremento de performance de computadoras y un uso intenso de lógica programable (FPGas, HDLS)..

# Tema 1: Hardware Description Languages (HDLs): VHDL y System Verilog (Un estudio comparativo)

<p align="center">Lenguajes utilizados para escribir Hardware (Según Pablo)
</p>

**VHDL**:  es un acrónimo para VHSIC Lenguaje de descripción de Hardware. VHSIC es un acrónimo para los proyectos de circuitos integrados de muy alta velocidad. Básicamente utilizado como un estándar. Muy utilizado para simulación y sintetización. VHDL es un lenguaje de modelado, no de especificación. _"Todo lo que existe puede ser modelado, pero no todo lo que se especifica puede ser sintetizado."_

**Verilog**: Fué desarrollado por Gateway Deign Automation como un lenguaje propieatario para la simulación lógica en 1984. En 1990 se convirtió en un estándar IEEE. Hay muchos textos en Verilog, pero el estándar IEEE es legible y autorizado. Lenguaje de descripción de Hardware utilizado para modelar sistemas electrónicos. A veces llamado Verilog HDL (Hardware Description Language).

```vhdl
-- VHDL
library IEEE; use IEEE.STD_LOGIC_1164.all

-- Interfaz
entity sillyfunction is
    port(a, b, c: in STD_LOGIC;
         y:       out STD_LOGIC);
end sillyfunction;

-- Implementación
architecture synth of sillyfunction is
begin
    y <= ((not a) and (not b) and (not c)) or
         ((not a) and (not b) and c) or
         ((not a) and b and (not c)) or
         ((not a) and b and c) or
         (a and (not b) and (not c)) or
         (a and (not b) and c) or
         (a and b and (not c)) or
         (a and b and c);
end;
```
**System Verilog:** Es una extensión de Verilog que incluye muchas características nuevas y mejoradas para la descripción de hardware y la verificación.

```verilog
//System Verilog
//Combinacional
module sillyfunction(input logic a, b, c, output logic y);
    assign y = ~a & ~b & ~c |
               ~a & ~b & c  |
               ~a & b & ~c
```

```vhdl
--VHDL  
--Tener en cuenta que en la salida y las entradas son vectores de 32 bits
library IEEE; use IEEE.STD_LOGIC_1164.all
use IEEE.STD_LOGIC_UNSIGNED.all

entity adder is
    port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
         y: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture synth of adder is
begin
    y <= a + b;
end;
```

```verilog
//System Verilog
//Ahora tener en cuenta que las entradas y salidas son base de 32 bits
module adder(input logic [31:0] a, 
            input logic [31:0] b, 
            output logic [31:0] y);
    assign y = a + b;
end;
```

> Las operaciones de VHDL y System Verilog se realizan bit a bit. 

Entonces con todos estos ejemplos tenemos que si asignamos una arquitectura `synth` estaremos declarando un bloque de hardware que se va a sintetizar en un chip. (Grafiquito de compuertas; Sintetizador -> Chip)

## Operadores de Reducción
VDHL no tiene operadores de reducción, pero System Verilog si. En caso de VHDL lo podemos definir explícitamente.

```verilog
//System Verilog
module and8(input logic [7:0] a, output logic y);
    assign y = &a;

    //&a is much easier to write than
    // assign y = a[0] & a[1] & a[2] & a[3] & a[4] & a[5] & a[6] & a[7];    
endmodule
```
```VHDL
--VHDL
library IEEE; use IEEE.STD_LOGIC_1164.all

entity and8 is
    port (a: in STD_LOGIC_VECTOR(7 downto 0);
          y: out STD_LOGIC);
end;

architecture synth of and8 is
begin
    y <= a(0) and a(1) and a(2) and a(3) and a(4) and a(5) and a(6) and a(7);
end;
```
![alt text](imgs/image.png)

## Multiplexores
Literalmente (o no tanto) es como un if.
    
```verilog
//System Verilog
//Impementación de un multiplexor de 4 entradas con "2 mux".
module mux4(input logic [3:0] d0,d1,d2,d3,
               input logic [1:0] s,
               output logic y);

    asign y = s[1] ? (s[0] ? d3 : d2) 
                   : (s[0] ? d1 : d0);  
endmodule 
```
```VHDL
library IEEE; use IEEE.STD_LOGIC_1164.all
entity mux4 is
    port(d0, d1, d2, d3: in STD_LOGIC;
         s: in STD_LOGIC_VECTOR(1 downto 0);
         y: out STD_LOGIC);
end;

architecture synth of mux4 is
begin
    y<= d0 when s = "00" else
        d1 when s = "01" else
        d2 when s = "10" else
        d3;
end;
```

En este caso el if está implícito en la asignación de `y`.

## Señales
En VHDL las señales son utilizadas para representar variables internas cuyos valores son definidos con señales concurrentes. Por ejemplo y <= a xor b.

En System Verilog las señales internas normalmente se definen como `logic`.

## Números

En System Verilog la notación es particular:
![alt text](imgs/image-2.png)
- Se debe tener muy en cuenta la notación, primero mencionamos la cantidad de bits con `x'` y si no está explícita "CREO" que se asume que es 32 bits.

-  `_` nos sirve para separar los bits y hacer más legible el código.

- Luego de definir la cantidad de bits con `'` luego definimos el tipo de número por ejemplo `b` para binario, `d` para decimal, `h` para hexadecimal, `o` para octal. Seguido de esto mencionamos el número dependiendo la familia que hayamos elegido.
    * Si no mencionamos nada se asume que es decimal.
- `'1` rellena con 1s a la izquierda en 32 bits.

## Zs y Xs
- `Z` significa que la señal está en alta impedancia.
- `X` significa que la señal es desconocida.

```VHDL
--VHDL
library IEEE; use IEEE.STD_LOGIC_1164.all
entity tristate is 
    port(a: in STD_LOGIC_VECTOR(3 downto 0);
         en: in STD_LOGIC;
         y: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture synth of tristate is
begin
    y <= "ZZZZ" when en = '0' else a;
end;
```

```verilog
//System Verilog
module tristate(input logic [3:0] a, 
                input logic en, 
                output logic [3:0] y);
    assign y = en ? a : 4'bz;
endmodule
```
![alt text](imgs/image-1.png)

## Bit Swizziling
- La concatenación en VHDL se hace con `&` y en System Verilog con `{}`.

```VHDL
--VHDL
y <= a(3 downto 0) & d(0) & d(0) & d(0);
```

```verilog
//System Verilog
//La notación es la de la GreenCard de Orga
assign y = {a[3:0], {3{d[0]}}, 3'b101};
```

```verilog
//System Verilog
// El resultado es la concatencación de upper y lower.
module mul(input logic [7:0] a, b,
           output logic [7:0] upper, lower);
    assign {upper, lower} = a * b;
endmodule
```


```verilog
//System Verilog
module signextend(input logic [15:0] a,
                  output logic [31:0] y);
    assign y = {{16{a[15]}}}, a[15:0];
endmodule
```

```VHDL
--VHDL
-- Tengo que implementar
```

![alt text](imgs/image-3.png)

## Delays
- En VHDL los delays se pueden especificar en la simulación, pero no en la síntesis.
- En System Verilog los delays se pueden especificar en la simulación y en la síntesis.

```verilog
//System Verilog
`timescale 1ns/1ps
module example(input logic a,v,c,
               output logic y);
    logic ab,bb,cb,n1,n2,n3;

    assign #1 {ab,bb,cb} = ~{a,b,c};
    assign #2 n1 = ab & bb & cb;
    assign #2 n2 = a & bb & cb;
    assign #2 n3 = a & bb & c;
    assign #4 y = n1 | n2 | n3;
endmodule
```

# Tema 2: Modelado Estructural y Comportamental

El modelado estructural es una forma de modelar un sistema en el que se especifica la estructura del sistema y cómo se conectan los componentes. El modelado estructural se puede hacer en VHDL y System Verilog.

```verilog
//System Verilog
module mux4(input logic [3:0] d0,d1,d2,d3,
               input logic [1:0] s,
               output logic y);

    logic [3:0] low, high;

    //mux2 se queda guardado en una librería local para otros usos.
    mux2 lowmux(d0,d1,s[0],low);
    mux2 highmux(d2,d3,s[0],high);
    mux2 finalmux(low,high,s[1],y);
endmodule
```
#### Partes de accesos de buses
```verilog
//System Verilog
module mux2_8 (input logic [7:0] d0, d1,
               input logic s,
               output logic [7:0] y);

    mux2 lsbmux (d0[3:0], d1[3:0], s, y[3:0]);
    mux2 msbmux (d0[7:4], d1[7:4], s, y[7:4]);
endmodule
```

![alt text](imgs/image-4.png)

#### Lógica secuencial - Registros

- Flip Flops:

    ```verilog
    //System Verilog
    //Flip-Flop
    module flop(input logic clk,
                input logic [3:0]d,
                output logic [3:0] q);

        //posedge: cuando haya un flanco de subida en clock.
        always_ff @(posedge clk)
            q <= d;
    endmodule
    ```

    > Diferencia entre `assign` y <=, si se pone assign se comporta como un combinacional, si se pone <= se comporta como un flip-flop en el sentido de que se actualiza en el flanco de subida.

    ![alt text](imgs/image-5.png)

- Registros reseteables:
    ```verilog
    //Reseteo Síncrono
    module flopr(input logic clk,
                 input logic reset,
                 input logic [3:0] d,
                 output logic [3:0] q);

        always_ff @(posedge clk)
            if (reset)
                q <= 4'b0;
            else
                q <= d;
    endmodule

    //Reseteo Asíncrono
    module flopr(input logic clk,
                 input logic reset,
                 input logic [3:0] d,
                 output logic [3:0] q);
    
        always_ff @(posedge clk, posedge reset)
            if (reset)
                q <= 4'b0;
            else
                q <= d;
    endmodule
    ```
    ![flopr(a) tiene reset síncrono y (b) reset asíncrono](imgs/image-6.png)


- Enabled Registers:
    ```verilog
    module flopenr(input logic clk,
                   input logic reset,
                   input logic en,
                   input logic [3:0] d,
                   output logic [3:0] q);
    
    //Reset síncrono
    always_ff @(posedge clk)
    if (reset) q <= 4'b0;
    else if (en) q <= d;
    endmodule
    ```

- Registros múltiples
    ```verilog
    module sync(input logic clk,
                input logic d,
                outpur logic q);

        logic n1;

        always_ff @(posedge clk)
            begin
                //El nuevo n1 es d
                n1 <= d;
                //El viejo n1 es q
                q <= n1;
            end
    endmodule
    ```

    > Si le dejas la flecha ocurre en paralelo y si le ponés igual ocurre en serie y los `comentarios` del código lo representan.

#### Latch
Los latch son flip-flops transparentes, es decir, que la salida se actualiza en el flanco de subida y bajada. En cambio los flip-flops se actualizan en el flanco de subida.

```verilog
    module latch(input logic clk,
                 input logic[3:0]d,
                 input logic[3:0]q);
        always_latch
        if(clk) q<=d;
    endmodule

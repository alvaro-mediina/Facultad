# 🤓 Arquitectura del Computador 💻


<p align="center"><img alt="Static Badge" src="https://img.shields.io/badge/LIVE-27ae60?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/Hardware%20-%20%231f618d?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/%23Chiqui%20-%20%23a04000?style=for-the-badge">

</p>

En este documento dejaré escrito todo el contenido de la materia, desde teoría, sección de laboratorio, libros,podcast, sugerencias entre otros.

## Indice
* [Información principal de la materia](#información-principal-de-la-materia)
* [Bibliografía](#bibliografía)
* [Teórico](#teórico)
* [Práctico](#practico)
* [Laboratorio](#laboratorio)

## Información principal de la materia

<p align="left" style="font-size:15px;">Clases: <strong style="font-size:15px; color: yellow;">Miercoles y Viernes 9AM a 13PM (4 horas cada día)</strong></p>

<p align="left" style="font-size:15px;">Profesor: <strong style="font-size:15px; color:yellow;">Pablo Ferreyra</strong></p>

<p align="left" style="font-size:15px;">Profesores: <strong style="font-size:15px; color:yellow;">Gonzalo Vodanovic - Delfina Velez - Agustín Laprovita </strong></p>

<p align="left" style="font-size:15px;">Aula: <strong style="font-size:15px; color:yellow;">Laboratorio 28</strong></p>


<p align="left" style="font-size:15px;">Modalidad: <strong style="font-size:15px; color:yellow;">Presencial</strong></p>

<p align="left" style="font-size:15px;">Carga horaria: <strong style="font-size:15px; color:yellow;">8 horas semanales</strong></p>

<p align="left" style="font-size:15px;"><li>Parciales:<ul>
        <li>Primer Parcial: <strong style="font-size:15px; color:yellow;">Insertar Fecha</strong></li>
        <li>Segundo Parcial: <strong style="font-size:15px; color:yellow;">Insertar Fecha</strong></li>
        <li>Recuperatorio (Sirve para promocionar): <strong style="font-size:15px; color:yellow;">Insertar Fecha</strong></li>
        </ul>
</p>

<p align="left" style="font-size:15px;"><li> Proyectos Finales: 2 (Dos)</p>


<p align="center" style="font-size:17px; color:green;">Promoción: Promedio 7 (siete) y nota mínima 6.
</p>

<p align="center" style="font-size:17px;">
Se puede promocionar utilizando recuperatorios pero <strong style="color:red">¡CUIDADO!</strong> Las notas de los recuperatorios se pisan con las notas de los parciales.
</p>


## Bibliografía

- CMOS VLSI Design: A Circuits and Systems Perspective (4th Edition) by Neil H. E. Weste, David Harris

## Teórico
Aprenderemos en detalle el funcionamiento interno y el incremento de performance de computadoras y un uso intenso de lógica programable (FPGas, HDLS)..

### Tema 1: Hardware Description Languages (HDLs): VHDL y System Verilog (Un estudio comparativo)

Lenguajes utilizados para escribir Hardware (Según Pablo)

> **VHDL**:  es un acrónimo para VHSIC Lenguaje de descripción de Hardware. VHSIC es un acrónimo para los proyectos de circuitos integrados de muy alta velocidad. Básicamente utilizado como un estándar.

> **Verilog**: Fué desarrollado por Gateway Deign Automation como un lenguaje propieatario para la simulación lógica en 1984. En 1990 se convirtió en un estándar IEEE. Hay muchos textos en Verilog, pero el estándar IEEE es legible y autorizado.

```vhdl
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
> System Verilog: Es una extensión de Verilog que incluye muchas características nuevas y mejoradas para la descripción de hardware y la verificación.

```verilog
//Combinacional
module sillyfunction(input logic a, b, c, output logic y);
    assign y = ~a & ~b & ~c |
               ~a & ~b & c  |
               ~a & b & ~c
```

```verilog
//Tener en cuenta que en la salida y las entradas son vectores de 32 bits
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
//Ahora tener en cuenta que las entradas y salidas son base de 32 bits
module adder(input logic [31:0] a, 
            input logic [31:0] b, 
            output logic [31:0] y);
    assign y = a + b;
end;
```

Entonces con todos estos ejemplos tenemos que si asignamos una arquitectura `synth` estaremos declarando un bloque de hardware que se va a sintetizar en un chip. (Grafiquito de compuertas; Sintetizador -> Chip)




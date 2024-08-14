# Ingeniería del Software I


<p align="center"><img alt="Static Badge" src="https://img.shields.io/badge/LIVE-27ae60?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/PRETTY-%238e44ad?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/respect-%23e74c3c?style=for-the-badge">

</p>

En este documento dejaré escrito todo el contenido de la materia, desde teoría, sección de laboratorio, libros,podcast, sugerencias entre otros.

## Indice
* [Información principal de la materia](#información-principal-de-la-materia)
* [Bibliografía](#bibliografía)
* [Teórico](#teórico)
* [Práctico](#practico)
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


A tener en cuenta:
- No se puede seguir con e proyecto si te quedás libre en el teórico.
- El tiempo vale oro.

## Bibliografía

- **Pakaj Jalote: “An Integrated Approach to Software Engineering”, 3ra ed., Springer**
- Oportunamente se brindará material adicional.

## Teórico

- Recomendación: Leer los capítulos antes de ir al teórico.

- [Resumen del libro de Jalote](Teórico/Resumen.md)

### Capítulo 1: Dominio del problema

---

Software (Según la IEEE): Colección de programas, procedimientos, y la documentación y datos asociados que determinan la operación de un sistema de computación.

A nivel **INDUSTRIA**:
- Los usuarios son otras personas.
- Aquí el **ERROR** no es tolerable.
- La interfaz con el usuario es muy importante (Porque vende más)
- Se requiere documentción tanto para el usuario como para la organización.


> La diferencia clave con el software pesnado por un alumno y el de nivel industrial radica en la calidad: usabilidad, confiabilidad, portabilidad, etcétera.

Para tener **alta calidad** se requiere mucho `testing`, que consume entre 30 y 50% del esfuerzo de desarrollo total. Se requiere la descomposición en etapas del desarrollo de manera de poder encontrar "bugs" en cada una de ellas, cada uno de diferente índole. Para la misma funcionalidad se incrementa el tamaño y los requerimientos: buena interfaz, backups, tolerancia a fallas, acatar estándares, etc.

Con todo lo anterior mencionado consideramos que el software industrial requiere un esfuerzo 10 veces mayor.

<p align="center" style="color: green; font-size:20px">El software es caro.</p>
<p align="center">Costos involucrados (320k/PM)</p>
<p align="center">Productividad = 500 LOC/PM</p>
<p align="center">Costo por línea = $640</p>


En software, en general, las fallas **NO** son consecuencia del uso y el deterioro. Las fallas ocurren como consecuencia de errores (o "bugs") introducidos durante el desarrollo.

Una vez entragado el software, éste requiere mantenimiento.

<p align="center"><strong>El mantenimiento puede costar más que el desarrollo del software</strong></p>

> **Desafíos de la IS:** Tratar de entender que el usuario/cliente quiere para crear el software; Satisfacer al cliente.

> Elección del enfoque: Escala, Calidad, Productividad, Consistencia y Cambio.

- **Escala:** Capacidad de adaptación y respuesta de un sistema con respecto al rendimiento del mismo a medida que aumentan o disminuyen de forma significativa el número de usuarios o requerimientos del mismo. Las dimensiones a considerar son: **Métodos de ingeniería y Administración del proyecto.**

- **Productividad:** Se mide el costo del software es principalmente el costo de la mano de obra, por lo que se mide Persona/Mes(PM). En términos de KLOC/PM captura a ambos conceptos: Si es más alta => menor costo y/o menor tiempo.

<p align="center"> El enfoque de la IS debe generar alta productividad</p>

- **Calidad - Estándar ISO:** La definición se reparte en:
        
        - Funcionalidad: Capacidad de proveer funciones que cumplen las necesidades establecidas(está escrito) o implicadas.

        - Confiabiliad: Capacidad de realizar las funciones requeridas bajo las condiciones establecidas durante un tiempo específico. 

        - Usabilidad: Capacidad de ser comprendido, aprendido y usado.

        - Eficiencia: Capacidad de proveer desempeño apropiado relativo a la cantidad de recursos usados.

        - Mantenibilidad: Capacidad de ser modificado con el propósito de corregir, mejorar, o adaptar.

        - Portabilidad: Capacidad de ser...

  Podemos deir que algo es bueno si: 1 defecto / KLOC

- **Cambio**:

- **Consistencia y repetitividad:**

### Enfoque de la Ingeniería del Software

 > Triangulo de Hierro -> Tecnología - Gente - Proceso

#### El proceso de desarrollo en fases
- El proceso de desarrollo consiste de varias fases.
  * Análisis de requisitos y especificación.
  * Arquitectura. (Hay pocos y es lo más pago)
  * Diseño. (Va de la mano con la arquitectura)
  * Codificación.
  * Testing. (No es bien paga excepto en las que son especializadas)
  * Entrega e Instalación.

- Cada fase termina con una salida definida.
- Las fases se realizan en el orden especificado por el modelo de proceso que elija seguir.
- El motivo de separar en fases es la **separación de incumbencias**: Cada fase manipula...

#### Administración del proceso
Se utilizará mucho la palabra `proceso`. 

El proceso de **desarrollo** no establece cómo asignar los recursos a las distintas tareas, ni cómo organizarlas temporalmente, ni cómo asegurar que cada fase se desarolló apropiadamente, etc. 

Estas cuestions se manejan a través de la **administración** del proceso. Sin la administración del proceso es virtualmente imposible cumplir con los objetivos de C&P.

Son importantes para poder planear y administrar las métricas y medidas.


#### Glosario
- KLOC: Líneas de Código en K. (Medida)
- LOC: Líneas de Código (Medida)
- PM: Persona/Mes
- Failure: Observación que tengo del "bug"
- Fault


### Capítulo 3: Análisis y especificación de los requisitos del software



## Práctico

## Laboratorio

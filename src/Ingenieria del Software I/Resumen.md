# Resumen del libro: **Texts in Computer Science: An Integrated Approach to Software Engineering**

En este archivo se encontrará un resumen para poder tener a mano los conceptos más importantes a mi parecer del libro de Pankaj Jalote.

---

<p align="center">Recomendación: Leer los capítulos antes de ir al teórico.
</p>

---

## Índice
- **[Chapter 1: Introduction](#chapter-1-introduction)**
    - [The Problem Domain](#the-problem-domain)
    - [The Software Engineering Challenges](#the-software-engineering-challenges)
    - [Summary](#summary)

- **[Chapter 3: Software Requirements Analysis and Specification](#chapter-3-software-requirements-analysis-and-specification)**


## Chapter 1: Introduction

### The Problem Domain

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

### Desafíos de la Ingeniería del Software

> Tratar de entender que el usuario/cliente quiere para crear el software; Satisfacer al cliente.

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
    * Los cambios en las empresas/instituciones es lo habitual.
    * El software debe cambiar para adaptarse a los cambios de dicha institución.
    * Las prácticas de IS deben preparar al software para que éste sea fácilmente modificable.
    * Los métodos que no permiten cambios, aún si producen alta calidad y productividad, son poco útiles.

- **Consistencia y repetitividad**: Algunas veces un grupo puede desarrollar un buen sistema de software.
    *  **Desafío en IS**: Cómo asegurar que el éxito pueda repetirse, con el fin de mantener alguna consistencia en la calidad y la productividad.
    * Un **Objetivo** de la IS es la sucesiva producción de sistemas de alta calidad y productividad.
    * La consistencia permite predecir el resultado del proyecto con certeza razonable. Sin consistencia sería difícil estimar costos.

### Enfoque de la Ingeniería del Software

 Pudimos entonces comprender el dominio del problema y los factores que motivan la IS: Consistentemente desarrollar software de alta calidad y con alta productividad (C&P o en inglés Q&P) para problemas de gran escala que se que se adaptan a los cambios. 

> Triangulo de Hierro -> Tecnología - Gente - Proceso

![alt text](imgs/image-1.png) 

- C&P: Son los objetivos básicos a perseguir bajo gran escala y tolerancia a cambios.
- C&P: Son consecuencia de la gente, los procesos y la tecnología.
- La IS separa el proceso para desarrollar software del producto desarrollado (i.e el software). Es aquí donde se distingue de las otra disciplinas informáticas.
- Premisa: El proceso es quien determina, en buena medida, la C&P => un proceso adecuado permitirá obtener gran C&P.
- Diseñar el **proceso apropiado y su control** es el desafío clave de la IS.



#### El proceso de desarrollo en fases
- El proceso de desarrollo consiste de varias fases:
  * Análisis de requisitos y especificación.
  * Arquitectura. (Hay pocos y es lo más pago)
  * Diseño. (Va de la mano con la arquitectura)
  * Codificación.
  * Testing. (No es bien paga excepto en las que son especializadas)
  * Entrega e Instalación.

- Los enfoques sistemáticos requieren que cada etapa se realice rigurosa y formalmente.

- Cada fase termina con una salida definida.
- Las fases se realizan en el orden especificado por el modelo de proceso que elija seguir.
- El motivo de separar en fases es la **separación de incumbencias**: Cada fase manipula distintos aspectos del desarrollo de software.
- El proceso en fases permite **verificar la calidad y progreso** en momentos definidos del desarrollo (al final de la fase).

> El proceso en fases es central en el enfoque de la IS para solucionar la crisis del software.

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
- C&P: Calidad y Productividad
- SRS: Software Requirement Specification

### Capítulo 3: Análisis y especificación de los requisitos del software

#### Introducción

> A medida que los sistemas se volvían más complejos, se hizo evidente que los objetivos de todo el sistema no podían comprenderse fácilmente. De ahí surgió la necesidad de un análisis de requisitos más riguroso. Ahora, para los grandes sistemas de software, el análisis de requirements es quizás la actividad más difícil e intratable; también es muy propensa a errores. Muchos creen que la disciplina de la ingeniería de software es más débil en esta área crítica.


>  La **fase de requirements** traduce las ideas en las mentes de los clientes (la entrada) en un documento formal (la salida de la fase de requirements). Así, la salida de esta fase es un conjunto de requirements especificados con precisión, que, con suerte, serán completos y consistentes, mientras que la entrada no tiene ninguna de estas propiedades. Claramente, el proceso de especificación de requirements no puede ser totalmente formal; cualquier proceso de traducción formal que produzca una salida formal debe tener una entrada precisa y sin ambigüedades.

> El analista de **requirements** tiene que identificar los requisitos hablando con estas personas y comprendiendo sus necesidades.

    Objetivo del Capítulo: Se discutirá qué son los requirements, por qué la especificación de requirements es importante, cómo se analizan y especifican los requirements, cómo se validan los requirements, y algunas métricas que pueden aplicarse a los requirements.


#### Software Requirements

Definición de la IEEE a **requirement**:
- Una condición o capacidad necesaria para que un usuario resuelva un problema o alcance un objetivo.
- Una condición o capacidad que debe ser cumplida o poseída por un sistema ... para satisfacer un contrato, estándar, especificación u otro documento impuesto formalmente.

> Es importante notar que en software requirements estamos tratando con los requisitos del sistema propuesto, es decir, las capacidades que el sistema, que aún está por desarrollarse, debería tener. Es porque estamos tratando de especificar un sistema que no existe que el problema de los requirements se vuelve complicado.

> El objetivo de la actividad de requirements es producir la Software Requirements Specification (SRS), que describe lo que el software propuesto debería hacer sin describir cómo lo hará.

> Producir el SRS es más fácil de decir que de hacer. Una limitación básica para esto es que las necesidades del usuario siguen cambiando a medida que cambia el entorno en el que el sistema debe funcionar con el tiempo.

#### Need for SRS



### Summary
    1. The problem domain for software engineering is industrial strength software. 

    2. Software engineering problem domain This software is not just a set of computer programs but **comprises programs** and associated **data** and **documentation**.

    Industrial strength software is expensive and difficult to build, expensive to maintain due to changes and rework, and has high quahty requirements.

    3. Software engineering is the discipline t h a t aims to provide methods and procedures for systematically developing industrial strength software. Thee main driving forces for software engineering are the problem of scale, quality and productivity (Q&P), consistency, and change. Achieving high Q & P consistently for problems whose scale may be large and where changes may happen continuously is the main challenge of software engineering.

    4. The fundamental approach of software engineering to achieve the objectives is to separate the development process from the products. Software engineering focuses on process since the quality of products developed and the productivity achieved are heavily influenced by the process used. To meet the software engineering challenges, this development process is a phased process. Another key approach used in Software Engineering for achieving high Q&P is to manage the process effectively and proactively using metrics.


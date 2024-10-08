# Sistemas Operativos

<p align="center"><img alt="Static Badge" src="https://img.shields.io/badge/LIVE-27ae60?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/PRETTY-%238e44ad?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/Long%20-%20%23C70039%20?style=for-the-badge">
<img alt="Static Badge" src="https://img.shields.io/badge/%23WOLO%20-%20%23F39C12?style=for-the-badge">
</p>

En este documento dejaré escrito todo el contenido de la materia, desde teoría, sección de laboratorio, libros,podcast, sugerencias entre otros.

## Indice
* [Información principal de la materia](#información-principal-de-la-materia)
* [Bibliografía](#bibliografía)
* [Teórico](Teórico.md)
* [Práctico](#practico)
* Laboratorios
    * [Laboratorio 0](Laboratorio/Laboratorio%200/README.md)

## Información principal de la materia

La idea es ver las clases grabadas ya que las clases presenciales estarán pensadas para el entendimiento de los temas y la resolución de dudas.

<p align="left" style="font-size:15px;">Clases: 
    <ul>
        <li><strong style="font-size:15px; color: yellow;">
            Martes (Virtual) 14:00 hs a 18:00 hs.</strong>
            <ul><li>Link: </li></ul>
        </li>
        <li><strong style="font-size:15px; color: yellow;">
            Jueves (Presencial) 14:00 hs a 18:00 hs.</strong>
        </li>
    </ul>
</p>

<p align="left" style="font-size:15px;">Profesor: <strong style="font-size:15px; color:yellow;">Nicolás Wolovick</strong></p>

<p align="left" style="font-size:15px;">Aula: <strong style="font-size:15px; color:yellow;">Pabellón de la Reforma, R5 y Laboratorio 17 ó 28.</strong></p>

<p align="left" style="font-size:15px;">Modalidad: <strong style="font-size:15px; color:yellow;">Presencial y Virtual</strong></p>

<p align="left" style="font-size:15px;">Carga horaria: <strong style="font-size:15px; color:yellow;">8 horas semanales</strong></p>

<p align="left" style="font-size:15px;">Parciales:<ul>
        <li>Primer Parcial: <strong style="font-size:15px; color:yellow;">Jueves 3 de Octubre (Virtualización)</strong></li>
        <li>Segundo Parcial: <strong style="font-size:15px; color:yellow;">Jueves 21 de Noviembre (Concurrencia y Persistencia)</strong></li>
        <li>Recuperatorio: <strong style="color:red;">aún no hay información.</strong> </li>
        </ul>
</p>

## Bibliografía
En particular se utilizará el libro:

<p align="center" style="font-size:20px"><a href="https://pages.cs.wisc.edu/~remzi/OSTEP/" target="_blank">
    Operating Systems: Three Easy Pieces</a>
</p>


## Laboratorio
En este apartado se encontrarán links a los distintas carpetas que contienen los laboratorios de la materia:

- [Laboratorio 0](Laboratorio/Laboratorio%200/README.md)

## Recursos Git
* git branch: Muestra las ramas que existen en el repositorio.
* git branch nombre_rama : Crea una nueva rama pero no se cambia a ella.
* git checkout -b nombre_rama: Crear una nueva rama y se cambia a ella.
* git checkout nombre_rama: Cambia a la rama que se le indica.

* El archivo .gitignore se utiliza para ignorar archivos o carpetas que no se quieren subir al repositorio. Dentro del .gitignore: * .o

Luego de agregar los cambios con add y hacer commit, para hacer push a la rama creada debo usar:
git push --set-upstream origin nombre_rama (seteo de rama a donde voy a pushear las cosas)

Ahora para unir la rama con la rama master debo hacer un pull request o merge request. Desde la página de Bitbucket en `create` seleccionar pull request.

Si por esas casualidades surgen problemas de implementación en la rama master, causada por un merge, se puede revertir. Crear una nueva rama, realizar git fetch origin, git merge origin/main. Luego corregir el error y hacer pull request.

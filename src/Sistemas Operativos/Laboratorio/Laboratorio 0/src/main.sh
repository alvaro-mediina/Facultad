#!/bin/bash

#Ejercicio 1
echo -e  "\nEjercicio 1: grep y cat\n" 
grep -m1 "model name"  /proc/cpuinfo

#Ejercicio 2
echo -e "\nEjercicio 2: wc\n"
echo "Cantidad de unidades de ejecución: $(grep 'model name' /proc/cpuinfo | wc -l)"

#Ejercicio 3
echo -e "\nEjercicio 3\n"
curl https://raw.githubusercontent.com/dariomalchiodi/superhero-datascience/master/content/data/heroes.csv | awk -F ";" '{print $2}'

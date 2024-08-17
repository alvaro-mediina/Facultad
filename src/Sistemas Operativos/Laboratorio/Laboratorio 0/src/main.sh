#!/bin/bash

#Ejercicio 1
echo -e  "\nEjercicio 1: grep y cat\n" 
grep -m1 "model name"  /proc/cpuinfo

#Ejercicio 2
echo -e "\nEjercicio 2: wc\n"
echo "Cantidad de unidades de ejecución: $(grep 'model name' /proc/cpuinfo | wc -l)"

#Ejercicio 3
echo -e "\nEjercicio 3\n"
curl https://raw.githubusercontent.com/dariomalchiodi/superhero-datascience/master/content/data/heroes.csv | awk -F ";" '{print $2}' | tr -d '[:blank:]' | tr '[:upper:]' '[:lower:]' | awk 'NF'

#Ejercicio 4
echo -e "\nEjercicio 4\n"
awk 'NR == 1 {maxDate[0] = $1; maxDate[1] = $2; maxDate[2] = $3; maxDate[3] = $5; minDate[0] = $1; minDate[1] = $2; minDate[2] = $3; minDate[3] = $6;  }; $5 > maxDate[3] {maxDate[3] = $5; maxDate[0] = $1; maxDate[1] = $2; maxDate[2] = $3}; $6 < minDate[3] {minDate[3] = $6; minDate[0] = $1; minDate[1] = $2; minDate[2] = $3} END {print "Max Temp. ", maxDate[3], " alcanzado en la fecha ",maxDate[0],"/",maxDate[1],"/",maxDate[2]; print "Min Temp ", minDate[3], " alcanzado en la fecha ",minDate[0],"/",minDate[1],"/",minDate[2]}' ../data/weather_cordoba.in

#Ejercicio 5
echo -e "\nEjercicio 5\n"
sort -k 3n ../data/atpplayers.in

#Ejercicio 6
awk '{diffGol = $7 - $8; print $0, diffGol}' superliga.in | sort -k2,2nr -k9,9nr | awk '{$NF=""; print $0}'  

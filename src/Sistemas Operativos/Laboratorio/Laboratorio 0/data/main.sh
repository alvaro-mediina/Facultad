#!/bin/bash

#Ejercicio 1
echo -e  "\nEjercicio 1\n" 
grep -m1 "model name"  /proc/cpuinfo

#Ejercicio 2
echo -e "\nEjercicio 2\n"
echo "Cantidad de unidades de ejecución: $(grep 'model name' /proc/cpuinfo | wc -l)"

#Ejercicio 3
echo -e "\nEjercicio 3\n"
curl https://raw.githubusercontent.com/dariomalchiodi/superhero-datascience/master/content/data/heroes.csv | awk -F ";" '{print $2}' | tr -d '[:blank:]' | tr '[:upper:]' '[:lower:]' | awk 'NF'

#Ejercicio 4
echo -e "\nEjercicio 4\n"
sort -k 5nr "weather_cordoba.in" > weather_cordoba_sorted_MaxTemp.in && awk 'NR==1 {print "Fecha maxima de max. Temp. registrada: "$1" "$2" "$3}' "weather_cordoba_sorted_MaxTemp.in" && awk 'END{print "Fecha minima de max. Temp. registrada: "$1" "$2" "$3}' "weather_cordoba_sorted_MaxTemp.in"

#Ejercicio 5
echo -e "\nEjercicio 5\n"
sort -k 3n atpplayers.in

#Ejercicio 6
echo -e "\nEjercicio 6\n"
awk '{diffGol = $7 - $8; print $0, diffGol}' superliga.in | sort -k2,2nr -k9,9nr | awk '{$NF=""; print $0}'

#Ejercicio 7
echo -e "\nEjercicio 7\n"
ip link show | grep -Eo 'link/ether [0-9a-f:]{17}' | awk '{print "MAC address:",$2}'

#Ejercicio 8
echo -e "\nEjercicio 8 \n"
mkdir Vikingos && cd Vikingos &&  for i in {1..10}; do touch "fma_S01E$(printf "%02d" $i)_es.srt"; done && echo "Archivos fma_S01EX_es.srt creados con éxito." && for file in fma_S01E*_es.srt; do mv "$file" "${file/_es/}"; done && echo "Archivos fma_S01EX.srt modificados"

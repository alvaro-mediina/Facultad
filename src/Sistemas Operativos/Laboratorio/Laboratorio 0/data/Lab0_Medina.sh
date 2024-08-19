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

#Como antes hice cd me encuentro en la carpeta Vikingos, vuelvo a donde se encuentra este ejecutable.
cd ..

#Ejercicio 9.1
echo -e "\nEjercicio 9.1\n"
#Recorto el video considerando formatos de audio y video comunes para la salida
ffmpeg -i video.mp4 -ss 00:00:05 -to 00:00:10 -c:v libx264 -c:a aac video_recortado.mp4

#Ejercicio 9.2
echo -e "\nEjercicio 9.2\n"
#Establezco las respectivas ganancias tanto para la voz ([0]volume) como para la música de fondo ([1]volume)
#Luego las superpongo y establezco la salida en un audio estéreo y codifico el audio resultante en mp3
ffmpeg -i voz.mp3 -i hello_world_Louie.mp3 -filter_complex "[0]volume=1.0[a]; [1]volume=0.3[b]; [a][b]amix=inputs=2:duration=first:dropout_transition=2" -ac 2 -c:a mp3 audio_final.mp3   

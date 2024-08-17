#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
#include <assert.h>

void Spin(int seconds) {
    time_t start = time(NULL);
    while (time(NULL) - start < seconds) {
        // Bucle vacío que consume tiempo
    }
}


// Tener en cuenta que arc es la cantidad de argumentos
// y argv es un array de strings que contiene el r-valor de los arg.
// argv[0] es el nombre del programa
// argv[1] es el primer argumento
// argv[2] es el segundo argumento
int main (int argc, char *argv[]){
    if (argc != 2){
        fprintf(stderr, "usage: cpu <string>\n");
        exit(1);
    }
    char *str = argv[1];
    while(1){
        Spin(1);
        printf("%s\n", str);
    }
    return 0;
}
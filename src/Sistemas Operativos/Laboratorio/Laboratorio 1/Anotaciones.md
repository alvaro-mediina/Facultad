# Anotaciones del laboratorio 1

Tener en cuenta las prioridades de las operaciones del bash. Como por ejemplo:

```bash
cal | wc -l > report.txt 
```
* La operación predominante es el `|` por lo que primero se ejecuta `cal | wc -l` y luego se redirecciona la salida a `report.txt`.

* "./ " es el directorio actual. 
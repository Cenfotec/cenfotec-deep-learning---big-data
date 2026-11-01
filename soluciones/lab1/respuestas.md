# Laboratorio 1 · Respuestas de referencia

Son respuestas modelo: se acepta cualquier respuesta que muestre la misma idea con palabras propias.

## 1. ¿Por qué los tokens se guardan como secretos y no en el código? ¿Qué podría pasar si uno se sube a GitHub?

Un token es una credencial: quien lo tiene actúa en nombre de su dueño. Si está en el código, viaja con cada copia del notebook y queda en el historial de Git aunque luego se borre. En un repositorio público hay bots que buscan tokens en minutos y pueden usarlos para leer o borrar datos, o gastar recursos de la cuenta. Si se filtra uno, hay que revocarlo de inmediato y crear otro.

## 2. ¿Qué ventaja tiene guardar los datos en bronce exactamente como llegaron, sin limpiarlos?

Bronce es la copia fiel de la fuente. Si una regla de limpieza resulta equivocada, se puede corregir y volver a procesar desde bronce sin pedirle los datos otra vez a la fuente, que puede haber cambiado o dejado de existir. También permite auditar: comparar lo que llegó con lo que se transformó. Los metadatos de carga dicen cuándo y de qué archivo vino cada fila.

## 3. La API entrega los datos por páginas. ¿Qué le pasa a la extracción si una página falla a la mitad, y cómo lo detectarías?

Si el error no se maneja, pueden pasar dos cosas: el proceso se cae y no se guarda nada, o, peor, sigue con las páginas siguientes y queda un hueco de hasta 100 filas sin que nadie lo note. Se detecta comparando la cantidad de filas extraídas con `num_rows_total` (o con el conteo esperado por split), y usando `raise_for_status()` para que un error HTTP no pase en silencio. Los reintentos con espera ayudan con fallos temporales como el 429 (demasiadas solicitudes).

## Verificación de la Parte 3

```
filas | archivos | fecha_carga             | total_ok | archivos_ok | metadatos_ok
3030  | 3        | 2026-11-10T19:42:11.000 | null     | null        | null
```

`assert_true` devuelve `null` cuando la condición se cumple; si falla, la celda da error.

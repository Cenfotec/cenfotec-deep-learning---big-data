-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Laboratorio 1 · Parte 3: Capa bronce
-- MAGIC
-- MAGIC La capa **bronce** guarda los datos **tal como llegaron**: sin limpiar, sin filtrar, sin cambiar tipos. Solo se le agregan columnas de metadatos que dicen cuándo y de dónde se cargó cada fila. Así, si algo sale mal más adelante, siempre se puede volver a la fuente.
-- MAGIC
-- MAGIC **Cómo abrir este notebook:** en Databricks, **Workspace → Create → Git folder**, pega la URL de tu repositorio y abre `lab1/parte3_bronce.sql`. Conéctalo a **Serverless** y ejecuta las celdas en orden.
-- MAGIC
-- MAGIC Completa las celdas `-- TODO`; las de verificación te dicen si vas bien.

-- COMMAND ----------

USE CATALOG workspace;
USE SCHEMA dlbd;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 1. Revisar lo que llegó
-- MAGIC
-- MAGIC Lista la carpeta del volumen y mira las primeras filas. `read_files()` lee archivos directamente desde una ruta, sin crear una tabla.

-- COMMAND ----------

LIST '/Volumes/workspace/dlbd/raw/tweets/'

-- COMMAND ----------

SELECT *
FROM read_files('/Volumes/workspace/dlbd/raw/tweets/', format => 'parquet')
LIMIT 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 2. Crear la tabla bronce
-- MAGIC
-- MAGIC Crea `dlbd.bronze_tweets` con **todas** las columnas de los archivos y dos columnas de metadatos:
-- MAGIC
-- MAGIC | Columna | Contenido | Pista |
-- MAGIC |---|---|---|
-- MAGIC | `_fecha_carga` | fecha y hora de la carga | `current_timestamp()` |
-- MAGIC | `_archivo_origen` | ruta del archivo de donde viene la fila | `_metadata.file_path` |
-- MAGIC
-- MAGIC El guion bajo al inicio es una convención para distinguir los metadatos de los datos.

-- COMMAND ----------

-- TODO: completa la consulta para crear dlbd.bronze_tweets
CREATE OR REPLACE TABLE dlbd.bronze_tweets AS
SELECT
  *
  -- TODO: agrega las dos columnas de metadatos
FROM read_files(
  -- TODO: ruta de la carpeta y formato de los archivos
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 3. Verificar
-- MAGIC
-- MAGIC Ejecuta las tres celdas. Si alguna condición no se cumple, la celda falla con un mensaje.

-- COMMAND ----------

DESCRIBE TABLE dlbd.bronze_tweets

-- COMMAND ----------

-- Filas por split: train 1838, validation 323, test 869
SELECT
  split,
  count(*) AS filas,
  assert_true(
    count(*) = CASE split WHEN 'train' THEN 1838 WHEN 'validation' THEN 323 WHEN 'test' THEN 869 END,
    concat('Cantidad incorrecta en ', split)
  ) AS verificacion
FROM dlbd.bronze_tweets
GROUP BY split
ORDER BY split

-- COMMAND ----------

-- Resumen final: copia esta salida en respuestas.md
SELECT
  count(*) AS filas,
  count(DISTINCT _archivo_origen) AS archivos,
  min(_fecha_carga) AS fecha_carga,
  assert_true(count(*) = 3030, 'La tabla debe tener 3030 filas') AS total_ok,
  assert_true(count(DISTINCT _archivo_origen) = 3, 'Deben ser 3 archivos de origen') AS archivos_ok,
  assert_true(count_if(_fecha_carga IS NULL OR _archivo_origen IS NULL) = 0, 'Hay metadatos vacíos') AS metadatos_ok
FROM dlbd.bronze_tweets

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Entrega
-- MAGIC
-- MAGIC Este archivo queda en tu repositorio desde el Git folder: **Git → Commit & push**. Copia la salida de la celda de resumen en `lab1/respuestas.md`.

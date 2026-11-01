-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Laboratorio 1 · Parte 3: Capa bronce
-- MAGIC
-- MAGIC > **Este archivo es un notebook de Databricks.** No se abre en Colab ni se ejecuta desde GitHub. Si lo estás viendo en GitHub como texto con líneas `-- MAGIC`, sigue los pasos de *Cómo abrirlo* (abajo) para trabajarlo en Databricks.
-- MAGIC
-- MAGIC La capa **bronce** guarda los datos **tal como llegaron**: sin limpiar, sin filtrar, sin cambiar tipos. Solo se le agregan columnas de metadatos que dicen cuándo y de dónde se cargó cada fila. Así, si algo sale mal más adelante, siempre se puede volver a la fuente.
-- MAGIC
-- MAGIC ## Cómo abrirlo
-- MAGIC
-- MAGIC 1. En Databricks, ve a **Workspace** (barra izquierda) y entra a tu carpeta de usuario.
-- MAGIC 2. Clic en **Create → Git folder**. Pega la URL de **tu** repositorio (por ejemplo `https://github.com/ana-mora/dlbd-cenfotec`) y clic en **Create Git folder**. Esto se hace una sola vez: el mismo Git folder sirve para todos los laboratorios.
-- MAGIC 3. Dentro del Git folder, abre `lab1` → `parte3_bronce`. Databricks lo muestra como notebook, con celdas.
-- MAGIC 4. Arriba a la derecha, en **Connect**, elige **Serverless**.
-- MAGIC 5. Ejecuta las celdas en orden con **Shift + Enter**.
-- MAGIC
-- MAGIC Completa las celdas `-- TODO`; las de verificación te dicen si vas bien.

-- COMMAND ----------

-- Notebook de Databricks: ábrelo desde un Git folder (ver «Cómo abrirlo» arriba).
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
-- MAGIC
-- MAGIC **Salida esperada:** `DESCRIBE TABLE dlbd.bronze_tweets` (en la sección 3) muestra estas columnas:
-- MAGIC
-- MAGIC | col_name | data_type |
-- MAGIC |---|---|
-- MAGIC | text | string |
-- MAGIC | label | bigint |
-- MAGIC | split | string |
-- MAGIC | _fecha_carga | timestamp |
-- MAGIC | _archivo_origen | string |
-- MAGIC
-- MAGIC Y una fila de la tabla se ve así:
-- MAGIC
-- MAGIC | text | label | split | _fecha_carga | _archivo_origen |
-- MAGIC |---|---|---|---|---|
-- MAGIC | estoy hasta el ojete de que me digáis que tengo cara de mala leche | 0 | train | 2026-11-10T19:42:11.000 | /Volumes/workspace/dlbd/raw/tweets/tweets_train.parquet |

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

-- Filas por split: train 1839, validation 324, test 870
SELECT
  split,
  count(*) AS filas,
  assert_true(
    count(*) = CASE split WHEN 'train' THEN 1839 WHEN 'validation' THEN 324 WHEN 'test' THEN 870 END,
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
  assert_true(count(*) = 3033, 'La tabla debe tener 3033 filas') AS total_ok,
  assert_true(count(DISTINCT _archivo_origen) = 3, 'Deben ser 3 archivos de origen') AS archivos_ok,
  assert_true(count_if(_fecha_carga IS NULL OR _archivo_origen IS NULL) = 0, 'Hay metadatos vacíos') AS metadatos_ok
FROM dlbd.bronze_tweets

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Entrega
-- MAGIC
-- MAGIC Este archivo queda en tu repositorio desde el Git folder: **Git → Commit & push**. Copia la salida de la celda de resumen en `lab1/respuestas.md`.

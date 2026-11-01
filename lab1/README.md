# Laboratorio 1 · De la API a la capa bronce

Las tres partes se hacen en orden. Cada una se abre en una herramienta distinta:

| Parte | Archivo | Dónde se trabaja | Cómo abrirlo |
|---|---|---|---|
| 1. Cuentas y acceso | `parte1_verificacion.ipynb` | Google Colab | En Colab: **Archivo → Abrir cuaderno → GitHub**, tu repositorio, este archivo. |
| 2. Extracción y carga | `parte2_extraccion.ipynb` | Google Colab | Igual que la Parte 1. |
| 3. Capa bronce | `parte3_bronce.sql` | **Databricks** | La primera vez, conecta Databricks con GitHub (**Settings → Linked accounts → Git integration**). Luego: **Workspace → Create → Git folder** con la URL de tu repositorio y cualquier nombre en *Git folder name*; dentro, abre `lab1` → `parte3_bronce` y conéctalo a **Serverless**. |

> `parte3_bronce.sql` es un **notebook de Databricks**. En GitHub se ve como texto con líneas `-- MAGIC`: es normal. No lo abras en Colab.

Al terminar, en esta carpeta deben quedar:

- `parte1_verificacion.ipynb` y `parte2_extraccion.ipynb`, guardados desde Colab con sus salidas (**Archivo → Guardar una copia en GitHub**, misma ruta).
- `parte3_bronce.sql`, subido desde el Git folder de Databricks (**Commit & push**).
- `respuestas.md`, con las preguntas de reflexión y la salida de la verificación final de la Parte 3.

Los detalles de cada paso están en los **Primeros pasos** del README principal del repositorio.

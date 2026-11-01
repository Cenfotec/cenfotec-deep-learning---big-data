# Deep Learning y Big Data con Python

CENFOTEC · SINT-646

**Estudiante:** _escribe aquí tu nombre completo_

## Primeros pasos

Se hacen una sola vez, al inicio del curso.

### 1. Crea tu repositorio

1. En esta página, arriba a la derecha, clic en **Use this template → Create a new repository**.
2. Ponle un nombre (por ejemplo `dlbd-cenfotec`) y déjalo **público**.
3. En **tu** repositorio, abre este `README.md`, clic en el lápiz ✏️ y escribe tu nombre en la línea *Estudiante*. Guarda con **Commit changes**.

A partir de aquí trabajas siempre en tu repositorio, no en la plantilla.

### 2. Abre un notebook en Colab

Si abres un `.ipynb` desde el explorador de archivos de Colab, se ve como texto. Ábrelo siempre desde GitHub:

1. Entra a https://colab.research.google.com con tu cuenta de Google.
2. **Archivo → Abrir cuaderno → GitHub**. La primera vez, Colab te pide autorizar el acceso a GitHub: acepta.
3. Escribe tu usuario de GitHub, elige tu repositorio y el notebook (por ejemplo `lab1/parte1_verificacion.ipynb`).

Atajo: en la dirección del notebook en GitHub, cambia `github.com` por `colab.research.google.com/github`.

### 3. Guarda tu trabajo en GitHub

Colab no guarda en GitHub automáticamente. Al terminar (o cada cierto tiempo):

1. **Archivo → Guardar una copia en GitHub**.
2. Elige tu repositorio, la rama `master` y la **misma ruta** del notebook (por ejemplo `lab1/parte1_verificacion.ipynb`).
3. Escribe un mensaje corto y clic en **Aceptar**.

Guárdalo después de ejecutar las celdas: así quedan las salidas, que son parte de la entrega.

### 4. Conecta tu repositorio a Databricks

Los notebooks `.sql` se trabajan en Databricks. Primero conecta Databricks con tu cuenta de GitHub (una sola vez), para poder subir cambios:

1. En Databricks, tu perfil (arriba a la derecha) → **Settings → Linked accounts → Git integration**.
2. Elige **GitHub** y **Link Git account**. Se abre GitHub: autoriza a Databricks. Si GitHub pregunta a qué repositorios dar acceso, elige **Only select repositories** y marca tu repositorio del curso.

   (También existe la opción de un token personal de GitHub, *Personal access token*, pero no hace falta.)

Después crea el Git folder:

1. En Databricks, **Workspace → Create → Git folder**.
2. Pega la URL de tu repositorio **solo hasta su nombre**, por ejemplo `https://github.com/ana-mora/dlbd-cenfotec` (sin `/tree/master` ni nada más al final). Si la URL está bien, **Git folder name** se llena solo; si queda vacío, revisa la URL. Deja **Sparse checkout mode** sin marcar y clic en **Create Git folder**.
3. Abre el notebook (por ejemplo `lab1/parte3_bronce.sql`). Para subir tus cambios: botón de Git (rama arriba del notebook) → **Commit & push**.

## Laboratorios nuevos

Los laboratorios se publican a lo largo del curso, y las soluciones de cada uno después de su fecha de entrega. Para traerlos a tu repositorio:

1. En **tu** repositorio en GitHub, abre la pestaña **Actions**. La primera vez, si GitHub lo pide, clic en **I understand my workflows, go ahead and enable them**.
2. Elige **Actualizar laboratorios** → **Run workflow** → **Run workflow**.
3. En un minuto aparecen las carpetas nuevas (por ejemplo `lab2/` o `soluciones/lab1/`).

Solo agrega carpetas que todavía no tienes: **nunca toca un laboratorio en el que ya trabajaste**. Si tienes el Git folder de Databricks abierto, después usa **Pull** para ver los cambios ahí.

## Estructura

| Carpeta | Contenido |
|---|---|
| `lab1/`, `lab2/`, `lab3/` | Un laboratorio por carpeta, con su propio README que explica cómo abrir cada parte |
| `soluciones/` | Soluciones de referencia, publicadas después de cada entrega |

Cada notebook trae celdas listas para ejecutar, celdas `# TODO` que completas tú y celdas de verificación que te dicen si vas bien.

## Herramientas

- **Google Colab** para los notebooks de Python.
- **Databricks Free Edition** para SQL y las tablas del pipeline.
- **Hugging Face** como fuente de datos y modelos. Usamos datos y modelos públicos, así que no necesitas cuenta.

## Regla de oro

Los tokens **nunca** se escriben en el código ni se suben a GitHub. En Colab se guardan como secretos (ícono 🔑) y se leen con `userdata.get("NOMBRE")`.

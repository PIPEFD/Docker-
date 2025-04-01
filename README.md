# 🐳 Docker - 📖 Introducción y 🚀 Proyecto Inception

## 🐋 ¿Qué es Docker?

Docker es una 🚢 plataforma que permite desarrollar, enviar y ejecutar 📦 aplicaciones mediante contenedores ligeros y portátiles. Estos contenedores incluyen todo lo necesario para ejecutar la aplicación, como 💻 código, 📚 dependencias, 📖 bibliotecas y ⚙️ configuraciones específicas, asegurando que funcionen consistentemente en diferentes 🌍 entornos.

Para una guía más detallada y oficial sobre Docker, visita la [📖 documentación oficial de Docker](https://docs.docker.com/).

## 📁 Estructura básica de Docker

- 📄 **Dockerfile:** Archivo que define la configuración del contenedor, desde la imagen base, instalación de dependencias, hasta ejecución de comandos necesarios.
- 🖼️ **Docker Image:** Resultado de compilar el Dockerfile. Es un 📦 paquete ligero y ejecutable.
- 📦 **Docker Container:** Instancia ejecutable de una imagen.
- 🔧 **Docker Compose:** Herramienta que permite definir y ejecutar aplicaciones Docker con múltiples 📦 contenedores mediante un archivo YAML (`docker-compose.yml`).

## ♻️ Funcionamiento general

1. Se crea un 📄 **Dockerfile** especificando una 🖼️ imagen base y comandos para configurar el entorno.
2. Se genera una 🖼️ **imagen Docker** ejecutando `docker build`.
3. Se ejecuta la imagen generada como 📦 **contenedor** usando `docker run`.
4. Para gestionar múltiples servicios interconectados, se usa 🔧 **Docker Compose**, facilitando el despliegue y comunicación entre contenedores.

## 🛠️ Instalación detallada de Docker en Ubuntu (WSL2) - Versión requerida por el proyecto Inception: Docker Engine estable más reciente compatible con Ubuntu según la documentación oficial

Para la instalación oficial y actualizada de Docker en Ubuntu (WSL2), sigue las instrucciones en la [📖 documentación oficial de Docker para Ubuntu](https://docs.docker.com/engine/install/ubuntu/).

### 🚩 Resumen rápido de instalación:

1. 🔃 Actualizar paquetes del sistema:

```bash
sudo apt update
sudo apt upgrade -y
```

2. 📅 Instalar dependencias necesarias:

```bash
sudo apt install -y ca-certificates curl gnupg lsb-release
```

3. 🔑 Añadir clave GPG y repositorio oficial de Docker:

```bash
🛠️ Paso 3 - Añadir clave GPG y repositorio oficial de Docker
🔒 1. Crear directorio para las claves:

sudo mkdir -p /etc/apt/keyrings
Esto crea el directorio donde se almacenarán las claves GPG usadas para verificar que los paquetes que vas a instalar son auténticos.

🔑 2. Descargar y guardar la clave GPG oficial de Docker:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
Este comando descarga la clave de autenticación de Docker y la convierte al formato apropiado (.gpg) para que el sistema pueda usarla.

📦 3. Añadir el repositorio de Docker a la lista de fuentes APT:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
Este comando añade la fuente oficial de Docker a tu sistema, permitiéndote instalar Docker desde allí.

arch=$(dpkg --print-architecture): detecta si tu sistema es amd64, arm64, etc.

$(lsb_release -cs): obtiene el nombre clave de tu distribución de Ubuntu (como jammy, focal, etc).
```

🧰📦 Paso 4 - Instalar Docker Engine y herramientas asociadas
Primero, actualiza la lista de paquetes, ya que acabamos de añadir un nuevo repositorio:

bash
Copiar
Editar
sudo apt update
Luego, instala Docker y sus herramientas oficiales:

bash
Copiar
Editar
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
🧩 ¿Qué estás instalando exactamente?

- docker-ce: Docker Community Edition (el motor principal de Docker).
- docker-ce-cli: La interfaz de línea de comandos de Docker (docker).
- containerd.io: El runtime que ejecuta contenedores.
- docker-buildx-plugin: Permite crear imágenes multiplataforma.
- docker-compose-plugin: Permite usar docker compose (nueva versión integrada del clásico docker-compose).

📌 Importante: según el subject de Inception, no puedes usar imágenes listas de DockerHub (excepto Alpine/Debian). Esto implica que deberás construir tus propias imágenes más adelante, y estos componentes son clave para lograrlo.

👤 Paso 5 - Usar Docker como usuario no-root

1. Agrega tu usuario al grupo docker:
   bash
   Copiar
   Editar
   sudo usermod -aG docker \$USER
   Esto le dice al sistema: “Este usuario tiene permiso para usar Docker sin necesidad de sudo”.

2. Aplica el cambio con este comando:
   bash
   Copiar
   Editar
   newgrp docker
   Esto actualiza tu grupo actual en la sesión actual (sin tener que cerrar sesión).

✅ Verifica que ya puedes usar Docker sin sudo:
bash
Copiar
Editar
docker run hello-world
Este comando ejecutará un contenedor de prueba. Si ves un mensaje que dice algo como:

Hello from Docker!

️ Paso 6 (Opcional) - Iniciar Docker automáticamente al abrir WSL2
Por defecto, Docker no arranca solo dentro de WSL2. Si quieres que se inicie automáticamente cada vez que abras tu terminal, puedes automatizarlo con este pequeño truco:

📅 Añadir al .bashrc:
bash
Copiar
Editar
echo "sudo service docker start > /dev/null 2>&1" >> \~/.bashrc
Esto añadirá una línea al final de tu archivo .bashrc, que es ejecutado cada vez que inicias una terminal. El > /dev/null 2>&1 es para que no muestre mensajes molestos cada vez que abras la terminal.

🧠 Nota: Esto no es necesario si usas Docker Desktop para WSL2 o si inicias el servicio manualmente con sudo service docker start.

🔀 Aplica los cambios:
bash
Copiar
Editar
source \~/.bashrc
✅ ¡Listo! Si decides no aplicar este paso, puedes simplemente arrancar Docker manualmente cuando lo necesites:

bash
Copiar
Editar
sudo service docker start

7. ✅ Verificar instalación:

```bash
docker run hello-world
```
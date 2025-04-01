# 🐳 Docker - 📖 Introducción y 🚀 Proyecto Inception

## 🐋 ¿Qué es Docker?
Docker es una 🚢 plataforma que permite desarrollar, enviar y ejecutar 📦 aplicaciones mediante contenedores ligeros y portátiles. Estos contenedores incluyen todo lo necesario para ejecutar la aplicación, como 🖥️ código, 📚 dependencias, 📖 bibliotecas y ⚙️ configuraciones específicas, asegurando que funcionen consistentemente en diferentes 🌍 entornos.

Para una guía más detallada y oficial sobre Docker, visita la [📖 documentación oficial de Docker](https://docs.docker.com/).

## 📁 Estructura básica de Docker

- 📄 **Dockerfile:** Archivo que define la configuración del contenedor, desde la imagen base, instalación de dependencias, hasta ejecución de comandos necesarios.
- 🖼️ **Docker Image:** Resultado de compilar el Dockerfile. Es un 📦 paquete ligero y ejecutable.
- 📦 **Docker Container:** Instancia ejecutable de una imagen.
- 🔧 **Docker Compose:** Herramienta que permite definir y ejecutar aplicaciones Docker con múltiples 📦 contenedores mediante un archivo YAML (`docker-compose.yml`).

## 🔄 Funcionamiento general

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

2. 📥 Instalar dependencias necesarias:
```bash
sudo apt install -y ca-certificates curl gnupg lsb-release
```

3. 🔑 Añadir clave GPG y repositorio oficial de Docker:
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

4. 📦 Instalar Docker Engine:
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin (verificar 📖 documentación oficial para compatibilidad con versión requerida por el proyecto Inception)
```

5. 👤 Ejecutar Docker como usuario no-root:
```bash
sudo usermod -aG docker $USER
newgrp docker
```

6. 🚀 Iniciar Docker automáticamente en WSL2:
```bash
echo "sudo service docker start" >> ~/.bashrc
source ~/.bashrc
```

7. ✅ Verificar instalación:
```bash
docker run hello-world
```

## 🚧 Proyecto Inception

Este proyecto tiene como objetivo profundizar en conocimientos de administración de sistemas utilizando Docker. Debe configurarse una infraestructura virtual con estos componentes:

- 🌐 **NGINX:** Servidor web configurado con protocolo TLSv1.2 o TLSv1.3.
- 📝 **WordPress:** Aplicación web usando PHP-FPM.
- 🗃️ **MariaDB:** Base de datos para almacenar información de WordPress.

### 🔑 Requisitos clave del proyecto
- Usar Alpine o Debian (penúltima versión estable).
- Cada servicio en un contenedor independiente.
- Uso obligatorio de variables de entorno y `.env`.
- 🔒 Gestión segura de contraseñas y secretos (no en Dockerfiles).
- 🌐 Comunicación mediante red Docker específica.
- 💾 Persistencia de datos usando volúmenes Docker.

### 🖥️ Diagrama visual simplificado del proyecto:

```
👤 Usuario
   │
   │ HTTPS (443, TLS)
   ▼
🌐 NGINX Container ────────────┐
   │                        │
   ▼                        ▼
📝 WordPress Container ──▶ 🗃️ MariaDB Container
```

### 📂 Estructura básica del proyecto
```
Inception/
├── 📃 Makefile
├── 🔒 secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── 📁 srcs/
    ├── docker-compose.yml
    ├── .env
    └── 📂 requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── conf/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        └── wordpress/
            ├── Dockerfile
            └── conf/

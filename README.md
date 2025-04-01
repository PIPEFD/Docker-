
# Docker - Introducción

## ¿Qué es Docker?
Docker es una plataforma que permite desarrollar, enviar y ejecutar aplicaciones mediante contenedores ligeros y portátiles. Estos contenedores incluyen todo lo necesario para ejecutar la aplicación, como código, dependencias, bibliotecas y configuraciones específicas, lo que asegura que funcionen consistentemente en diferentes entornos.

## Estructura básica de Docker

- **Dockerfile:** Archivo donde se define la configuración del contenedor, desde la imagen base, instalación de dependencias, hasta la ejecución de comandos necesarios.
- **Docker Image:** Resultado de compilar el Dockerfile. Es un paquete ligero y ejecutable.
- **Docker Container:** Una instancia ejecutable de una imagen.
- **Docker Compose:** Herramienta que permite definir y ejecutar aplicaciones Docker con múltiples contenedores mediante un archivo YAML (`docker-compose.yml`).

## Funcionamiento general

1. Se crea un **Dockerfile** especificando una imagen base y los comandos para configurar el entorno.
2. Se genera una **imagen Docker** ejecutando `docker build`.
3. Se ejecuta la imagen generada como **contenedor** usando `docker run`.
4. Para gestionar múltiples servicios interconectados, se usa **Docker Compose**, facilitando el despliegue y la comunicación entre contenedores.

## Proyecto Inception

Este proyecto tiene como objetivo profundizar en conocimientos de administración de sistemas utilizando Docker. Se debe configurar una infraestructura virtual con los siguientes componentes:

- **NGINX:** Servidor web configurado con protocolo TLSv1.2 o TLSv1.3.
- **WordPress:** Aplicación web utilizando PHP-FPM.
- **MariaDB:** Base de datos para almacenar información de WordPress.

### Requisitos clave del proyecto
- Utilizar Alpine o Debian (penúltima versión estable).
- Cada servicio debe correr en un contenedor independiente.
- Uso obligatorio de variables de entorno y `.env`.
- Gestión segura de contraseñas y secretos (no en Dockerfiles).
- Comunicación entre contenedores mediante red Docker específica.
- Persistencia de datos usando volúmenes Docker.

### Diagrama visual simplificado del proyecto:

```
Usuario
   │
   │ HTTPS (443, TLS)
   ▼
NGINX Container ────────────┐
   │                        │
   ▼                        ▼
WordPress Container ──▶ MariaDB Container
```

### Estructura básica del proyecto
```
Inception/
├── Makefile
├── secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── conf/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        └── wordpress/
            ├── Dockerfile
            └── conf/
```

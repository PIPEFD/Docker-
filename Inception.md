# 🐳 Inception 🏗️🏗️

Este proyecto tiene como objetivo profundizar en conocimientos de administración de sistemas utilizando Docker. Debe configurarse una infraestructura virtual con estos componentes:

- 🌐 **NGINX:** Servidor web configurado con protocolo TLSv1.2 o TLSv1.3.
- 📝 **WordPress:** Aplicación web usando PHP-FPM.
- 🗃️ **MariaDB:** Base de datos para almacenar información de WordPress.

## 🔑 Requisitos clave del proyecto

- Usar Alpine o Debian (penúltima versión estable).
- Cada servicio en un contenedor independiente.
- Uso obligatorio de variables de entorno y `.env`.
- 🔒 Gestión segura de contraseñas y secretos (no en Dockerfiles).
- 🌐 Comunicación mediante red Docker específica.
- 📂 Persistencia de datos usando volúmenes Docker.

## 💻 Diagrama visual simplificado del proyecto:

```
👤 Usuario
   │
   │ HTTPS (443, TLS)
   ▼
🌐 NGINX Container ─────────────────────┐
   │                        │
   ▼                        ▼
📝 WordPress Container ──▶ 🗃️ MariaDB Container
```

## 📂 Estructura básica del proyecto

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
```
## 🛠️ Crear y definir un Makefile inicial para automatizar procesos básicos:

-build

-up

-down

-clean

-fclean

## 🐳 Docker (solo CLI) vs Docker Compose


| Característica                          | Docker CLI (manual)                          | Docker Compose (automático con YAML)          |
|----------------------------------------|----------------------------------------------|-----------------------------------------------|
| Definición de servicios                | Manual, uno por uno con `docker run`         | Declarativa, con YAML (`docker-compose.yml`)  |
| Orquestación de múltiples contenedores | Difícil, poco práctico                        | Súper fácil, un solo comando                  |
| Reutilización                          | Manual, se repite cada comando               | Automático, reproducible                      |
| Variables de entorno                   | A mano con `-e`                              | Centralizadas con `.env`                     |
| Redes y volúmenes                      | Se crean manualmente                         | Se declaran y gestionan automáticamente       |
| Mantenimiento                          | Difícil, poco escalable                      | Sencillo y limpio                             |
| Ideal para…                            | Contenedores sueltos, pruebas rápidas        | Proyectos con múltiples servicios             |

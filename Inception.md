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

- build

- up

- down

- clean

- fclean

### 🔑 Crear el archivo .env con todas las variables esenciales (contraseñas, usuarios, etc).


## 🛠️ Fase 2: Creación del servicio MariaDB

- Escribir el Dockerfile para MariaDB usando Debian Bullseye o Alpine.

- Crear archivo de configuración personalizada dentro de conf/ (opcional, pero recomendado).

- Configurar el servicio en docker-compose.yml:

- Variables de entorno desde .env.

- Volumen persistente para base de datos.

- Red personalizada.

- Validar que MariaDB funciona correctamente (docker-compose up -d mariadb).
---

## 🌐 Fase 3: Creación del servicio WordPress
- Crear Dockerfile personalizado para WordPress con PHP-FPM.

- Configurar conexión a MariaDB mediante variables del .env.

- Configurar volumen persistente para los archivos de WordPress.

-  Validar el funcionamiento WordPress + MariaDB juntos.
---

## 🚦 Fase 4: Creación del servicio NGINX con TLS

- Crear Dockerfile personalizado para NGINX (Debian o Alpine).

- Configurar SSL/TLS (TLSv1.2 o superior).

- Redireccionar el tráfico HTTPS hacia el contenedor WordPress.

- Probar que la conexión HTTPS funciona correctamente.
---
## ⚙️Fase 5: Automatización y pruebas finales
### Ajustar el Makefile con tareas claras:

- make all → Build + Up

- make down → Detener servicios

- make clean → Eliminar volúmenes y contenedores

- make fclean → Limpieza total (contenedores, imágenes y volúmenes)

- Realizar pruebas exhaustivas de:

- Persistencia (datos tras detener/reiniciar servicios).

- Funcionamiento HTTPS.

- Seguridad básica (no ejecución como root en los contenedores).
---

## ✅ Fase 6: Aplicación de buenas prácticas

- Usar imágenes base ligeras (Alpine o mínima versión Debian).

- Aplicar Multi-stage builds en Dockerfiles si es necesario.

- Nunca guardar secretos en Dockerfiles, solo usar .env o secrets/.

- Optimizar el orden de instrucciones en Dockerfiles para aprovechar el caché de Docker.

- Usar redes específicas en Docker Compose.

- Asegurar que los contenedores no ejecuten procesos como usuario root.
---

## 🌟 Fase 7 (Bonus): Agregar servicios adicionales
 ### El subject de Inception tiene bonus interesantes para ampliar conocimientos avanzados:

- Servicio de administración de bases de datos (Adminer o PhpMyAdmin).

- Caché (Redis).

- Servidor FTP.

- Certificado automático con Let's Encrypt (Certbot).

- Sistema de monitoreo (netdata, Grafana, etc.).

## 📚 Fase 8: Documentación final
### Actualizar Docker.md, Docker Compose.md e Inception.md en README con:

- Explicaciones claras del proceso.

- Diagramas visuales.

- Comandos esenciales.

- Troubleshooting básico.
---

## 🚩 Checklist final (para evaluación)
- Jerarquía y estructura exacta del subject.

- docker-compose.yml completo y funcional.

- .env y secrets correctamente gestionados.

- Uso de volúmenes y redes específicas.

- Funcionamiento correcto de SSL/TLS.

- Servicios funcionando de forma independiente.

- Makefile automatizando todas las tareas esenciales.

-  Documentación clara, completa y explicativa.

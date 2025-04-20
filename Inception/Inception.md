# Inception Project

Este repositorio contiene la configuración completa del proyecto **Inception** para desplegar un stack LEMP (MariaDB, WordPress, Nginx) sobre Docker. A continuación encontrarás:

- 📋 **Resumen del proyecto**
- 🛠️ **Estructura de carpetas y archivos**
- ✅ **Resultados de la auditoría**
- 🚀 **Instrucciones de instalación y puesta en marcha**
- 🔧 **Tareas pendientes**

---

## 📋 Resumen del proyecto

Inception es un entorno Dockerizado que incluye:

- **MariaDB** con inicialización automática de la base de datos y usuario.
- **WordPress** corriendo sobre PHP-FPM y WP-CLI.
- **Nginx** como proxy inverso con SSL (autofirmado o mkcert para local).
- Scripts y Makefile para gestión simplificada (build, reset, healthcheck, debug).

---

## 🛠️ Estructura de carpetas

```
Makefile
Makefile.md
scripts/          # utilidades: check_env, clean, diagnostics, setup, healthcheck
secrets/          # credenciales y contraseñas (db, root, WP)
srcs/             # código de servicios
  docker-compose.yml
  .env
  requirements/
    mariadb/      # Dockerfile, conf/init.sh, conf/my.cnf
    wordpress/    # Dockerfile, conf/wp-config.php, wait-for-mariadb.sh
    nginx/        # Dockerfile, conf/default.conf, html/error502.html, wait-for-wordpress.sh
volumes/          # datos persistentes (mariadb-data, wordpress-data)
```


## 🚀 Instalación y puesta en marcha

1. **Clonar el repositorio**:
   ```bash
   git clone <URL_REPO>
   cd Inception
   ```
2. **Configurar secretos** en `secrets/`:
   - `db_password.txt`
   - considerand`db_root_password.txt`
   - `credentials.txt`
3. **Generar certificados SSL** (opcional, local confiable):
   ```bash
   mkcert -install
   mkcert -key-file ssl/localhost-key.pem -cert-file ssl/localhost.pem localhost 127.0.0.1 ::1
   ```
4. **Levantar el entorno**:
   ```bash
   make all           # build + up
   ```
5. **Verificar estado**:
   ```bash
   make monitor
   make check-nginx-response
   ```
6. **Abrir en el navegador**:
   [https://localhost](https://localhost)

---

## 🔧 Tareas pendientes

-
---

Con este README tendrás una visión completa de la configuración, auditoría y próximos pasos para el proyecto **Inception**. ¡Éxito en tu defensa!


# 🛠️ Manual de Uso del Makefile - Proyecto Inception

Este documento describe las reglas disponibles en el Makefile del proyecto Inception y cómo utilizarlas para administrar los contenedores y servicios Docker (WordPress, MariaDB y NGINX).

---

## 🧱 SECCIÓN: BUILD

### `make all`
> Verifica puertos, secretos y construye todos los servicios, luego los levanta.

### `make build`
> Construye todas las imágenes: WordPress, MariaDB y NGINX.

### `make build-wordpress`
> Solo construye la imagen de WordPress.

### `make build-mariadb`
> Solo construye la imagen de MariaDB.

### `make build-nginx`
> Solo construye la imagen de NGINX.

### `make rebuild`
> Elimina los contenedores y volúmenes, fuerza reconstrucción sin caché, y levanta todo de nuevo.

---

## 🔄 SECCIÓN: RESET

### `make reset-wp`
> Elimina y reconstruye WordPress desde cero.

### `make reset-db`
> Elimina y reconstruye MariaDB desde cero.

### `make reset-nginx`
> Elimina y reconstruye NGINX desde cero.

### `make reset-all`
> Elimina todos los volúmenes y contenedores, reconstruye y levanta todo.

---

## ✅ SECCIÓN: CHECK

### `make check_ports`
> Verifica que los puertos 80 y 443 estén libres.

### `make check`
> Verifica que los archivos `.env` y secretos estén presentes.

### `make verify-secrets`
> Comprueba que los archivos de secretos existen y no están vacíos.

---

## 🔍 SECCIÓN: STATUS / DEBUG

### `make up`
> Levanta los contenedores definidos en `docker-compose.yml`.

### `make down`
> Detiene y elimina los contenedores (sin eliminar volúmenes).

### `make logs`
> Muestra los logs en tiempo real de todos los servicios.

### `make status`
> Muestra tabla de contenedores activos, IPs, puertos y volúmenes.

### `make debug`
> Ejecuta un chequeo completo del sistema (estado y salud).

### `make healthcheck`
> Verifica si MariaDB, WordPress (php-fpm) y NGINX están funcionando correctamente.

---

## 🧰 SECCIÓN: UTILS

### `make clean`
> Elimina contenedores y volúmenes usados por `docker-compose`.

### `make fclean`
> Limpieza total: borra caché, volúmenes y contenedores huérfanos.

### `make monitor`
> Monitoreo completo del sistema: estado de contenedores, IPs, uso de recursos, certificado SSL y más.

### `make print-config`
> Muestra las variables cargadas desde `.env`.

### `make volume-size`
> Muestra el tamaño de los volúmenes usados.

---

## 📌 CONSEJOS
- Usa `make monitor` para diagnosticar todo el sistema de un vistazo.
- Usa `make reset-wp` o `make reset-db` si WordPress o MariaDB presentan errores críticos.
- Siempre verifica los puertos antes de lanzar con `make all`.
- Mantén tus secretos seguros y fuera del control de versiones.

---

## 📝 Requisitos
- Docker y Docker Compose instalados.
- Archivos `.env`, `db_password.txt`, `db_root_password.txt` y `credentials.txt` en la ruta correcta.

---

> 🧠 *Este Makefile fue diseñado para cumplir con los estándares del proyecto, sigue buenas prácticas de administración de contenedores Docker.*


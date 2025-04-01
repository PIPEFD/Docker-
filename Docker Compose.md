# 🐳 Docker Compose 🐋

Para una guía más detallada y oficial sobre Docker Compose, visita la [📖 documentación oficial de Docker Compose](https://docs.docker.com/compose/).

## 🔧 ¿Qué es Docker Compose?
Docker Compose es una herramienta oficial de Docker que permite definir, configurar y ejecutar múltiples contenedores a la vez usando un solo archivo YAML ```bash (docker-compose.yml)```

## 📦 ¿Por qué usar Docker Compose?
En vez de tener que correr varios comandos:
```bash 
docker run
```
para levantar tus servicios (como una base de datos, un servidor web y una aplicación), Docker Compose lo hace todo de una sola vez, de forma orquestada.


![demo](https://i.gifer.com/A7Hl.gif)

## 🔄 ¿Cómo funciona?
### 1. 📄 Archivo docker-compose.yml
Este archivo contiene toda la configuración de tus servicios. Ejemplo:

```yaml
version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "80:80"
  db:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
```
Aquí definimos 2 servicios:

#### web: 
Que usa la imagen de nginx y expone el puerto 80.

#### db: 
Que usa la imagen de mariadb y define una contraseña por variable de entorno.

## 2. 🛠️ Comandos principales
Levanta todos los contenedores definidos.
```Dockerfile
docker-compose up: 
```
Los apaga y desmonta redes/volúmenes.

```Dockerfile
docker-compose down:
```
Construye las imágenes si estás usando Dockerfile.

```Dockerfile
docker-compose build: 
```
Muestra los logs de los servicios.
```Dockerfile
docker-compose logs:
```
## Ejemplo:
```bash
docker-compose up -d
```
Levanta todo en segundo plano (-d = detached).

# ¿Qué incluye Docker Compose?
### Servicios:
Cada contenedor que usas (nginx, wordpress, mariadb…).

### Redes: 
Se crean automáticamente, para que los servicios puedan comunicarse entre sí.

### Volúmenes: 
Para que los datos persistan aunque reinicies el contenedor.

### Variables de entorno: 
Puedes usar un archivo .env para centralizar claves y configuraciones.

# 🔁 Flujo de trabajo típico con Docker Compose
#### Creas tu estructura de carpetas y docker-compose.yml.

#### Defines tus servicios, redes y volúmenes.

#### Usas docker-compose up para levantar todo el entorno.

#### Puedes hacer docker-compose down para limpiarlo o reiniciarlo.

# 🧠 Ventajas
✅ Fácil de usar

✅ Define todo en un solo archivo

✅ Reproducible: puedes compartir tu stack con otros

✅ Ideal para entornos de desarrollo y proyectos complejos con múltiples servicios
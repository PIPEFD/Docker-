# 🐳 Docker Compose 🐋

Para una guía más detallada y oficial sobre Docker Compose, visita la [📖 documentación oficial de Docker Compose](https://docs.docker.com/compose/).

La especificación Compose establece un estándar para la definición de aplicaciones multicontenedor independientes de la plataforma. [Puede consultar la especificación](https://github.com/compose-spec/compose-spec/blob/main/00-overview.md)
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
  servicio1:
    build: ./servicio1
    ports:
      - "8080:80"
    networks:
      - red-compose

  servicio2:
    image: alpine
    command: sleep infinity
    networks:
      - red-compose

networks:
  red-compose:
    driver: bridge
```
Aquí definimos servicios entre ellos :

#### web: 
Usa la imagen de nginx y expone el puerto 80.

#### db: 
Usa la imagen de mariadb y define una contraseña por variable de entorno.

## 2. 🛠️✅ Comandos útiles
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
#### 🧩 services
Cada servicio representa un contenedor. En este ejemplo hay 3:

- nginx

- wordpress

- mariadb

#### 🏗️ build

Indica la ruta donde está el Dockerfile de ese servicio.

#### 🌍 networks

Define una red virtual privada donde los contenedores se comunican entre sí (sin exponer servicios al exterior si no quieres).

#### 💾 volumes

Sirve para persistir datos entre reinicios del contenedor (muy importante para WordPress y bases de datos como MariaDB).

#### 🌐 ports

Relaciona puertos del host (tu máquina) con puertos del contenedor. Ejemplo: "443:443" expone HTTPS desde NGINX.
### Variables de entorno:

## 📁 Uso de variables de entorno con .env
Puedes usar un archivo .env para centralizar claves y configuraciones.
`
MYSQL_USER=user
MYSQL_PASSWORD=pass `

Y se usan directamente en el archivo YAML: 

```yaml
services:
  db:
    image: mariadb
    environment:
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
```
## 🧩 Buenas prácticas

- Utiliza redes personalizadas para separar entornos.

- Gestiona datos persistentes con volúmenes explícitos.

- Usa variables de entorno para secretos, nunca hardcodeados.

- Divide servicios en contenedores específicos para mantener aislamiento y seguridad.
Eso hace que `MYSQL_USER` se cargue automáticamente desde el archivo .env. ¡Mucho más limpio y seguro!

## 🧠 ¿Qué pasa cuando haces docker-compose up?
- Lee el `docker-compose.yml`

- Construye las imágenes si es necesario (build)

- Crea y levanta los contenedores

- Crea la red definida

- Monta los volúmenes persistentes

#### todo esto con un solo comando 🤯

# 🔁 Flujo de trabajo típico con Docker Compose
#### Creas tu estructura de carpetas y docker-compose.yml.

#### Defines tus servicios, redes y volúmenes.

#### Usas docker-compose up para levantar todo el entorno.

#### Puedes hacer docker-compose down para limpiarlo o reiniciarlo.

### 📦 ¿Dónde se guarda todo?
Imágenes: en tu sistema Docker (docker images)

- #### Contenedores: 
```bash 
docker ps -a
```

- #### Volúmenes: 
```bash 
docker volume ls
```
- #### Redes: `
```bash 
docker network ls
```

# 🧠 Ventajas
✅ Fácil de usar

✅ Define todo en un solo archivo

✅ Reproducible: puedes compartir tu stack con otros

✅ Ideal para entornos de desarrollo y proyectos complejos con múltiples servicios
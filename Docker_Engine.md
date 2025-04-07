
# 🐳🛵Docker Engine

<img src="https://i.gifer.com/3Myg.gif" alt="demo" loop autoplay>

## 🧠 ¿Qué es Docker Engine?


**Docker Engine** es un entorno de ejecución cliente-servidor que permite crear, ejecutar y administrar contenedores. Es la base tecnológica sobre la que funciona todo el ecosistema Docker.

---

## ⚙️ Componentes de Docker Engine

| Componente | Descripción | Rol en la arquitectura |
|------------|-------------|------------------------|
| **Docker Daemon (`dockerd`)** | Proceso que corre en segundo plano y gestiona los contenedores | Recibe instrucciones, ejecuta contenedores, gestiona imágenes |
| **Docker CLI (`docker`)** | Herramienta de línea de comandos | El usuario la utiliza para enviar órdenes al daemon |
| **Docker API** | API REST que expone funciones del daemon | Se puede usar desde scripts, aplicaciones o herramientas externas (como Docker Compose) |

---

## 🧪 ¿Qué puedes hacer con Docker Engine?

| Acción                        | Comando CLI                           | Resultado                                              |
|------------------------------|----------------------------------------|--------------------------------------------------------|
| Crear una imagen             | `docker build -t myapp .`             | Genera una imagen desde un `Dockerfile`               |
| Ejecutar un contenedor       | `docker run -d -p 80:80 nginx`        | Lanza un contenedor en segundo plano                  |
| Ver contenedores activos     | `docker ps`                           | Muestra contenedores corriendo                        |
| Parar un contenedor          | `docker stop <ID>`                    | Detiene el contenedor especificado                    |
| Crear una red personalizada  | `docker network create mynet`         | Crea una red virtual entre contenedores               |
| Usar volúmenes               | `docker run -v data:/data myapp`      | Monta un volumen persistente                          |

---

## 🧱 Arquitectura Simplificada

```
+------------------------+
|    Docker CLI (cliente)|
+------------------------+
            |
            v
+------------------------+     <--- Se comunican por socket o API REST
|  Docker Daemon (dockerd) |
+------------------------+
      |         |         |
      v         v         v
 [Contenedores] [Redes] [Volúmenes]
```

---

## 🛠️ Instalación y Ejecución

- En **Linux**: puedes instalar `docker-ce` desde el repositorio oficial
- En **Windows/Mac**: se usa **Docker Desktop**, que ejecuta Docker Engine dentro de una máquina virtual (usando WSL2 o Hyper-V)

---

## 🔍 Caso práctico

### ⚙️ Lanzar un servidor Nginx:

```bash
docker run -d -p 8080:80 nginx
```

- `-d`: lo lanza en segundo plano
- `-p 8080:80`: expone el puerto 80 del contenedor al 8080 del host
- `nginx`: imagen oficial de Nginx

Ahora puedes visitar `http://localhost:8080` para ver Nginx funcionando.

---

## 📌 Ventajas del Docker Engine

- **Portabilidad**
- **Ligereza**
- **Escalabilidad**
- **Control total del entorno**

---

## 🧠 Conclusión práctica

> Docker Engine te permite abstraerte del sistema operativo y enfocarte en el **comportamiento de tus aplicaciones**, haciéndolas más fáciles de desarrollar, probar, desplegar y escalar.


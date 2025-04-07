
# Docker Engine vs Docker Compose - Comparativa práctica

## 🆚 Diferencias clave

| Característica                     | **Docker Engine**                                      | **Docker Compose**                                          |
|----------------------------------|--------------------------------------------------------|-------------------------------------------------------------|
| 🔧 **Qué es**                     | El **motor base** de Docker                           | Una herramienta de **orquestación** basada en YAML         |
| 🎯 **Objetivo**                   | Ejecutar y gestionar contenedores individualmente     | Definir y lanzar **múltiples contenedores** como un sistema |
| 📦 **Nivel de trabajo**           | Bajo nivel (CLI directa, imagen por imagen)           | Alto nivel (define servicios completos en `docker-compose.yml`) |
| 🔄 **Modo de uso**                | Comandos como `docker run`, `docker stop`, etc.       | Un solo comando: `docker-compose up`                       |
| 🔗 **Gestión de redes/volúmenes** | Manual                                                 | Automática desde YAML                                      |
| 🧠 **Aprendizaje**                | Básico e indispensable                                | Opcional pero muy útil para proyectos reales               |
| 🔁 **Escalabilidad / Reutilización** | Menos reutilizable, más manual                        | Reutilizable, automatizable, ideal para DevOps             |
| 📂 **Archivo de configuración**  | No necesita (se trabaja en la línea de comandos)       | Usa `docker-compose.yml` y opcional `.env`                |
| ✅ **Ejemplo ideal**             | Probar una imagen aislada como `nginx` o `redis`       | Desplegar una app con **frontend + backend + DB**         |

---

## 🎯 Ejemplo comparativo

### 🔸 Docker Engine

```bash
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=1234 mysql
```

### 🔸 Docker Compose

```yaml
# docker-compose.yml
version: '3.8'
services:
  mysql:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=1234
```

```bash
docker-compose up -d
```

---

## 🧠 Relación entre ambos

- **Docker Engine es el motor.**
- **Docker Compose es una herramienta que usa ese motor**, pero de forma automatizada, declarativa y organizada.

> Piensa en Docker Engine como el **motor de un coche** y Docker Compose como el **GPS que planea la ruta y coordina todos los pasajeros**.

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


# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    clean_docker.sh                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/20 19:11:29 by dbonilla          #+#    #+#              #
#    Updated: 2025/04/20 19:11:35 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# clean_docker.sh
# Limpieza total o selectiva de contenedores, imágenes y volúmenes

set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
NC="\033[0m"

usage() {
  echo -e "${YELLOW}Uso: $0 [all|nginx|wordpress|mariadb]${NC}"
  echo -e "  all       → Limpia TODO el sistema Docker"
  echo -e "  nginx     → Limpia solo contenedor + imagen de Nginx"
  echo -e "  wordpress → Limpia solo contenedor + imagen de WordPress"
  echo -e "  mariadb   → Limpia solo contenedor + imagen de MariaDB"
  exit 1
}

clean_all() {
  read -p $'\033[1;33m⚠ Esto eliminará TODOS los contenedores, volúmenes e imágenes no utilizadas. ¿Deseas continuar? [y/N]: \033[0m' confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${RED}⛔ Operación cancelada por el usuario.${NC}"
    exit 1
  fi

  echo -e "${CYAN}🧹 Deteniendo y eliminando contenedores...${NC}"
  docker container stop $(docker container ls -aq) 2>/dev/null || true
  docker container rm $(docker container ls -aq) 2>/dev/null || true

  echo -e "${CYAN}🗑️  Eliminando volúmenes no utilizados...${NC}"
  docker volume prune -f

  echo -e "${CYAN}📦 Eliminando imágenes no utilizadas...${NC}"
  docker system prune -a -f

  echo -e "${GREEN}✅ Docker limpio completamente.${NC}"
}

clean_service() {
  SERVICE=$1
  CONTAINER_ID=$(docker ps -aqf "name=${SERVICE}")
  IMAGE_ID=$(docker images -qf "reference=srcs-${SERVICE}")

  echo -e "${CYAN}🧼 Eliminando servicio: ${SERVICE}${NC}"
  [ -n "$CONTAINER_ID" ] && docker stop "$CONTAINER_ID" && docker rm "$CONTAINER_ID"
  [ -n "$IMAGE_ID" ] && docker rmi -f "$IMAGE_ID"

  echo -e "${GREEN}✅ ${SERVICE^} limpiado correctamente.${NC}"
}

case "$1" in
  all) clean_all ;;
  nginx|wordpress|mariadb) clean_service $1 ;;
  *) usage ;;
esac
    
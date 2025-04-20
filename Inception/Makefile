# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/20 19:06:23 by pipe              #+#    #+#              #
#    Updated: 2025/04/20 19:11:14 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ========================
#        VARIABLES
# ========================

COMPOSE    = docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env

# Colores
DEF_COLOR  = \033[0;39m
GRAY       = \033[0;90m
RED        = \033[0;31m
GREEN      = \033[0;92m
YELLOW     = \033[0;93m
BLUE       = \033[0;94m
MAGENTA    = \033[0;95m
CYAN       = \033[0;96m
CLEAR      = \033[0m

# Timestamp y directorio de logs
TIMESTAMP := $(shell date +%Y-%m-%d_%H-%M-%S)
LOG_DIR := logs/logs-$(TIMESTAMP)

# ========================
#         BUILD
# ========================

all: check_ports check build up

build: build-wordpress build-mariadb build-nginx
	@echo "$(GREEN)✅ Build completo de todos los servicios.$(CLEAR)"

build-wordpress:
	@echo "$(BLUE)🔧 Construyendo WordPress...$(CLEAR)"
	@$(COMPOSE) build wordpress

build-mariadb:
	@echo "$(BLUE)🔧 Construyendo MariaDB...$(CLEAR)"
	@$(COMPOSE) build mariadb

build-nginx:
	@echo "$(BLUE)🔧 Construyendo Nginx...$(CLEAR)"
	@$(COMPOSE) build nginx

rebuild:
	@echo "$(MAGENTA)♻️ Reconstrucción completa...$(CLEAR)"
	@$(COMPOSE) down --volumes --remove-orphans
	@$(COMPOSE) build --no-cache
	@$(COMPOSE) up -d --force-recreate

# ========================
#         RESET
# ========================

reset-wp:
	@$(COMPOSE) stop wordpress || true
	@docker volume rm srcs_wordpress-data 2>/dev/null || true
	@docker rm -f $$(docker ps -aqf "name=wordpress") 2>/dev/null || true
	@$(COMPOSE) build wordpress
	@$(COMPOSE) up -d wordpress

reset-db:
	@$(COMPOSE) stop mariadb || true
	@docker volume rm srcs_mariadb-data 2>/dev/null || true
	@docker rm -f $$(docker ps -aqf "name=mariadb") 2>/dev/null || true
	@$(COMPOSE) build mariadb
	@$(COMPOSE) up -d mariadb

reset-nginx:
	@$(COMPOSE) stop nginx || true
	@docker rm -f $$(docker ps -aqf "name=nginx") 2>/dev/null || true
	@$(COMPOSE) build nginx
	@$(COMPOSE) up -d nginx

reset-all:
	@$(COMPOSE) down -v --remove-orphans
	@docker volume prune -f
	@$(COMPOSE) build
	@$(COMPOSE) up -d

# ========================
#         CHECK
# ========================

check_ports:
	@if lsof -i :80 -sTCP:LISTEN -t >/dev/null ; then \
		echo "$(RED)❌ Puerto 80 en uso.$(CLEAR)"; exit 1; fi
	@if lsof -i :443 -sTCP:LISTEN -t >/dev/null ; then \
		echo "$(RED)❌ Puerto 443 en uso.$(CLEAR)"; exit 1; fi
	@echo "$(GREEN)✅ Puertos libres.$(CLEAR)"

check:
	@bash ./scripts/check_secrets.sh
	@bash ./scripts/check_env.sh

verify-secrets:
	@for secret in db_password.txt db_root_password.txt credentials.txt; do \
		if [ ! -s "./secrets/$$secret" ]; then \
			echo "$(RED)❌ $$secret vacío o no existe.$(CLEAR)"; \
		else \
			echo "$(GREEN)✅ $$secret OK.$(CLEAR)"; fi; done

check-firewall:
	@echo "$(CYAN)🔐 Verificando reglas de firewall para puerto 443...$(CLEAR)"
	@sudo ufw status | grep -q '443/tcp' && echo "$(GREEN)✅ Puerto 443 permitido en UFW.$(CLEAR)" || echo "$(RED)❌ Puerto 443 no permitido o UFW inactivo.$(CLEAR)"
	@sudo iptables -L -n | grep -q '443' && echo "$(GREEN)✅ Reglas iptables para 443 encontradas.$(CLEAR)" || echo "$(YELLOW)⚠️ No se encontraron reglas iptables para el puerto 443.$(CLEAR)"

check-env-vars:
	@echo "$(CYAN)🔢 Comprobando variables de entorno cargadas desde .env...$(CLEAR)"
	@cat ./srcs/.env | grep -v '^#' | grep '=' || echo "$(YELLOW)⚠️ No hay variables definidas en .env$(CLEAR)"

bash-wordpress:
	@docker exec -it $$(docker ps -qf "name=wordpress") bash

bash-mariadb:
	@docker exec -it $$(docker ps -qf "name=mariadb") bash

bash-nginx:
	@docker exec -it $$(docker ps -qf "name=nginx") bash

check-nginx-response:
	@echo "$(MAGENTA)🔍 Verificando respuesta de Nginx sobre HTTPS...$(CLEAR)"
	@curl -vk --resolve localhost:443:127.0.0.1 https://localhost/index.php || echo "$(RED)❌ Fallo al contactar con Nginx$(CLEAR)"

check-ssl-cert:
	@echo "$(MAGENTA)📄 Verificando certificado SSL de Nginx...$(CLEAR)"
	@test -f ./srcs/requirements/nginx/conf/ssl/nginx.crt && echo "$(GREEN)✅ Certificado SSL presente.$(CLEAR)" || echo "$(RED)❌ Certificado SSL no encontrado.$(CLEAR)"
	@test -f ./srcs/requirements/nginx/conf/ssl/nginx.key && echo "$(GREEN)✅ Llave SSL presente.$(CLEAR)" || echo "$(RED)❌ Llave SSL no encontrada.$(CLEAR)"
	@docker exec -it $$(docker ps -qf "name=nginx") test -f /etc/nginx/ssl/nginx.crt && echo "$(GREEN)✅ Certificado presente dentro del contenedor.$(CLEAR)" || echo "$(RED)❌ Certificado no encontrado en el contenedor.$(CLEAR)"

# ========================
#         STATUS
# ========================

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

logs:
	@$(COMPOSE) logs -f

status:
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
	@docker volume ls --format "{{.Name}}"
	@docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $$(docker ps -q)

# ========================
#         DEBUG
# ========================

debug:
	@$(MAKE) healthcheck
	@$(MAKE) status

healthcheck:
	@docker exec -i $$(docker ps -qf "name=mariadb") mysqladmin ping -u root -p"$$(cat ./secrets/db_root_password.txt)" > /dev/null 2>&1 && echo "✅ MariaDB activo" || echo "❌ MariaDB no responde"
	@docker exec -i $$(docker ps -qf "name=wordpress") nc -z localhost 9000 > /dev/null 2>&1 && echo "✅ WordPress (php-fpm) activo" || echo "❌ WordPress no responde"
	@curl -sk https://localhost | grep -q "html" && echo "✅ Nginx sirviendo contenido" || echo "❌ Nginx no responde"

# ========================
#         UTILS
# ========================

clean:
	@$(COMPOSE) down -v --remove-orphans

fclean: clean
	@docker system prune -af
	@docker volume prune -f

monitor:
	@echo "$(MAGENTA)🔍 MONITOREO COMPLETO$(CLEAR)"
	@$(MAKE) healthcheck
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
	@docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $$(docker ps -q)
	@openssl x509 -in ./srcs/requirements/nginx/conf/ssl/nginx.crt -noout -dates 2>/dev/null || echo "❌ Certificado no encontrado."
	@test -f ./srcs/requirements/nginx/conf/ssl/nginx.crt && echo "✅ Certificado SSL generado en contenedor Nginx." || echo "❌ Certificado SSL no generado."
	@docker exec -it $$(docker ps -qf "name=nginx") test -f /etc/nginx/ssl/nginx.crt && echo "✅ Certificado SSL presente dentro del contenedor." || echo "❌ Certificado SSL no presente en el contenedor."
	@docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
	@docker logs --tail=10 $$(docker ps -qf "name=wordpress") || echo "⚠️ WordPress no disponible"
	@docker system df -v | grep 'srcs_' || echo "⚠️ No hay volúmenes activos"
	@docker volume ls -f dangling=true --format "{{.Name}}" || echo "⚠️ Ninguno encontrado"
	@$(MAKE) check-ssl-cert

print-config:
	@cat ./srcs/.env | grep -v '^#' | grep '='

volume-size:
	@docker system df -v | grep 'srcs_'

# ========================
#         LOGGING
# ========================

save-logs:
	@echo "$(CYAN)📝 Guardando logs completos de build y ejecución...$(CLEAR)"
	@mkdir -p $(LOG_DIR)
	@echo "$(GRAY)📆 Guardando logs del build...$(CLEAR)"
	@$(COMPOSE) build > $(LOG_DIR)/build.log 2>&1
	@echo "$(GRAY)🚀 Guardando logs de ejecución (up)...$(CLEAR)"
	@$(COMPOSE) up --build > $(LOG_DIR)/up.log 2>&1 &
	@sleep 5
	@echo "$(GRAY)📄 Guardando logs individuales por contenedor...$(CLEAR)"
	@for container in $$(docker ps --format '{{.Names}}'); do \
		echo "📅 $$container -> $(LOG_DIR)/$$container.log"; \
		docker logs $$container > $(LOG_DIR)/$$container.log 2>&1; \
	done
	@echo "$(GREEN)✅ Todos los logs fueron guardados en '$(LOG_DIR)'$(CLEAR)"

run:
	@echo "$(MAGENTA)🚀 Ejecutando build + up + save-logs...$(CLEAR)"
	@$(MAKE) build
	@$(MAKE) up
	@$(MAKE) save-logs

# ========================
#       PHONY TARGETS
# ========================

.PHONY: all build rebuild build-wordpress build-mariadb build-nginx reset-wp reset-db reset-nginx reset-all check check_ports check_env verify-secrets check-firewall check-env-vars bash-wordpress bash-mariadb bash-nginx check-nginx-response check-ssl-cert up down logs status debug healthcheck clean fclean monitor print-config volume-size save-logs run

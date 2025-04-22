# ========================
#        VARIABLES
# ========================

COMPOSE    = docker compose -f ./docker-compose.yml --env-file .env

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

build-wordpress:
	@echo "$(BLUE)🔧 Construyendo WordPress...$(CLEAR)"
	@$(COMPOSE) build wordpress

build-mariadb:
	@echo "$(BLUE)🔧 Construyendo MariaDB...$(CLEAR)"
	@$(COMPOSE) build mariadb

build-nginx:
	@echo "$(BLUE)🔧 Construyendo Nginx...$(CLEAR)"
	@$(COMPOSE) build nginx

build: build-wordpress build-mariadb build-nginx
	@echo "$(GREEN)✅ Build completo de todos los servicios.$(CLEAR)"

rebuild:
	@echo "$(MAGENTA)♻️ Reconstrucción completa...$(CLEAR)"
	@$(MAKE) down clean-data
	@$(COMPOSE) build --no-cache
	@$(MAKE) up

# ========================
#         RESET
# ========================

reset-wp:
	@$(COMPOSE) stop wordpress || true
	@sudo rm -rf ./data/wordpress/*
	@$(COMPOSE) up -d wordpress

reset-db:
	@$(COMPOSE) stop mariadb || true
	@sudo rm -rf ./data/mariadb/*
	@$(COMPOSE) up -d mariadb

reset-nginx:
	@$(COMPOSE) stop nginx || true
	@docker rm -f $$(docker ps -aqf "name=nginx") 2>/dev/null || true
	@$(COMPOSE) build nginx
	@$(COMPOSE) up -d nginx

reset-all:
	@$(MAKE) down clean-data build up

# ========================
#         SETUP
# ========================

generate-ssl:
	@echo "$(CYAN)🔐 Generando certificado SSL autofirmado...$(CLEAR)"
	@mkdir -p ./requirements/nginx/conf/ssl
	@if [ ! -f ./requirements/nginx/conf/ssl/nginx.key ] || [ ! -f ./requirements/nginx/conf/ssl/nginx.crt ]; then \
		DOMAIN=$$(grep DOMAIN_NAME .env | cut -d '=' -f2); \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout ./requirements/nginx/conf/ssl/nginx.key \
		-out ./requirements/nginx/conf/ssl/nginx.crt \
		-subj "/C=ES/ST=42/L=Inception/O=42/OU=Student/CN=$$DOMAIN"; \
		echo "$(GREEN)✅ Certificado SSL generado correctamente.$(CLEAR)"; \
	else \
		echo "$(YELLOW)⚠️  Certificado ya existe, omitiendo generación.$(CLEAR)"; \
	fi

configure-hosts:
	@echo "$(CYAN)📝 Añadiendo dominio personalizado al /etc/hosts (requiere sudo)...$(CLEAR)"
	@DOMAIN=$$(grep DOMAIN_NAME .env | cut -d '=' -f2); \
	if ! grep -q "$$DOMAIN" /etc/hosts; then \
		echo "127.0.0.1 $$DOMAIN" | sudo tee -a /etc/hosts > /dev/null && \
		echo "$(GREEN)✅ Dominio $$DOMAIN añadido a /etc/hosts.$(CLEAR)"; \
	else \
		echo "$(YELLOW)⚠️  Dominio $$DOMAIN ya existe en /etc/hosts.$(CLEAR)"; \
	fi

setup: generate-ssl
	@echo "$(CYAN)⚙️  Ejecutando setup inicial...$(CLEAR)"
	@bash ./scripts/setup.sh

# ========================
#         CHECK
# ========================

check_ports:
	@if lsof -i :80 -sTCP:LISTEN -t >/dev/null ; then \
		echo "$(RED)❌ Puerto 80 en uso.$(CLEAR)"; exit 1; fi
	@if lsof -i :443 -sTCP:LISTEN -t >/dev/null ; then \
		echo "$(RED)❌ Puerto 443 en uso.$(CLEAR)"; exit 1; fi
	@echo "$(GREEN)✅ Puertos libres.$(CLEAR)"

check-secrets:
	@bash ./scripts/check_secrets.sh

check-env:
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
	@cat .env | grep -v '^#' | grep '=' || echo "$(YELLOW)⚠️ No hay variables definidas en .env$(CLEAR)"

check-nginx-response:
	@echo "$(MAGENTA)🔍 Verificando respuesta de Nginx sobre HTTPS...$(CLEAR)"
	@DOMAIN=$$(grep DOMAIN_NAME .env | cut -d '=' -f2); \
	curl -vk --resolve $$DOMAIN:443:127.0.0.1 https://$$DOMAIN/index.php || echo "$(RED)❌ Fallo al contactar con Nginx en $$DOMAIN$(CLEAR)"

check-ssl-cert:
	@echo "$(MAGENTA)📄 Verificando certificado SSL de Nginx...$(CLEAR)"
	@test -f ./requirements/nginx/conf/ssl/nginx.crt && echo "$(GREEN)✅ Certificado SSL presente.$(CLEAR)" || echo "$(RED)❌ Certificado SSL no encontrado.$(CLEAR)"
	@test -f ./requirements/nginx/conf/ssl/nginx.key && echo "$(GREEN)✅ Llave SSL presente.$(CLEAR)" || echo "$(RED)❌ Llave SSL no encontrada.$(CLEAR)"
	@docker exec -it $$(docker ps -qf "name=nginx") test -f /etc/nginx/ssl/nginx.crt && echo "$(GREEN)✅ Certificado presente dentro del contenedor.$(CLEAR)" || echo "$(RED)❌ Certificado no encontrado en el contenedor.$(CLEAR)"

check: check_ports check-secrets check-env check-firewall check-env-vars check-nginx-response check-ssl-cert
	@echo "$(GREEN)✅ Todas las comprobaciones han pasado.$(CLEAR)"

# ========================
#         STATUS
# ========================

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down --remove-orphans

logs:
	@$(COMPOSE) logs -f

status:
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
	@docker volume ls --format "{{.Name}}"
	@docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $$(docker ps -q)

# ========================
#         BASH
# ========================


bash-wordpress:
	@docker exec -it $$(docker ps -qf "name=wordpress") bash

bash-mariadb:
	@docker exec -it $$(docker ps -qf "name=mariadb") bash

bash-nginx:
	@docker exec -it $$(docker ps -qf "name=nginx") bash

# ========================
#         DEBUG
# ========================
healthcheck:
	@bash ./scripts/healthcheck.sh

debug: healthcheck status

diagnose:
	@bash ./scripts/diagnostics.sh

# ========================
#         UTILS
# ========================

clean-data:
	@echo "$(RED)🧹 Eliminando datos persistentes...$(CLEAR)"
	@sudo rm -rf ./data/mariadb/* ./data/wordpress/*
	@sudo rm -rf ./requirements/nginx/conf/ssl/*
purge-data:
	@echo "$(RED)🗑️ Borrando completamente la carpeta de datos persistentes...$(CLEAR)"
	@sudo rm -rf ./data

clean:
	@$(COMPOSE) down -v --remove-orphans

fclean: clean clean-data
	@bash ./scripts/clean_docker.sh all

monitor: healthcheck
	@echo "$(MAGENTA)🔍 MONITOREO COMPLETO$(CLEAR)"
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
	@docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $$(docker ps -q)
	@openssl x509 -in ./requirements/nginx/conf/ssl/nginx.crt -noout -dates 2>/dev/null || echo "❌ Certificado no encontrado."
	@test -f ./requirements/nginx/conf/ssl/nginx.crt && echo "✅ Certificado SSL generado en contenedor Nginx." || echo "❌ Certificado SSL no generado."
	@docker exec -it $$(docker ps -qf "name=nginx") test -f /etc/nginx/ssl/nginx.crt && echo "✅ Certificado SSL presente dentro del contenedor." || echo "❌ Certificado SSL no presente en el contenedor."
	@docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
	@docker logs --tail=10 $$(docker ps -qf "name=wordpress") || echo "⚠️ WordPress no disponible"
	@docker system df -v | grep 'srcs_' || echo "⚠️ No hay volúmenes activos"
	@docker volume ls -f dangling=true --format "{{.Name}}" || echo "⚠️ Ninguno encontrado"
	@$(MAKE) check-ssl-cert

print-config:
	@cat .env | grep -v '^#' | grep '='

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

run: build up save-logs
	@echo "$(MAGENTA)🚀 Ejecutando build + up + save-logs...$(CLEAR)"

all: setup check build up

.PHONY: all \
		setup \
		generate-ssl \
		configure-hosts \
		build \
		build-wordpress \
		build-mariadb \
		build-nginx \
		rebuild \
		reset-wp \
		reset-db \
		reset-nginx \
		reset-all \
		check \
		check_ports \
		check-secrets \
		check-env \
		verify-secrets \
		check-firewall \
		check-env-vars \
		check-nginx-response \
		check-ssl-cert \
		up \
		down \
		logs \
		status \
		debug \
		healthcheck \
		diagnose \
		clean-data \
		purge-data \
		clean \
		fclean \
		monitor \
		print-config \
		volume-size \
		save-logs \
		run \
		bash-wordpress \
		bash-mariadb \
		bash-nginx \
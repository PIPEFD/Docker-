# ========================
#        VARIABLES
# ========================

COMPOSE		= docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env

# Colores
DEF_COLOR	= \033[0;39m
GRAY		= \033[0;90m
RED		    = \033[0;31m
GREEN		= \033[0;92m
YELLOW		= \033[0;93m
BLUE		= \033[0;94m
MAGENTA		= \033[0;95m
CYAN		= \033[0;96m
CLEAR		= \033[0m

spinner=|/-\\

# ========================
#         REGLAS
# ========================

all: check_ports check build up

check_ports:
	@echo "$(MAGENTA)🔍 Verificando puertos 80 y 443...$(CLEAR)"
	@if lsof -i :80 -sTCP:LISTEN -t >/dev/null ; then \
		echo "$(RED)❌ El puerto 80 ya está en uso. Detén el servicio que lo ocupa o cambia el puerto en docker-compose.yml$(CLEAR)"; \
		exit 1; \
	fi
	@if lsof -i :443 -sTCP:LISTEN -t >/dev/null ; then \
		echo "$(RED)❌ El puerto 443 ya está en uso. Detén el servicio que lo ocupa o cambia el puerto en docker-compose.yml$(CLEAR)"; \
		exit 1; \
	fi
	@echo "$(GREEN)✅ Puertos libres. Continuando...$(CLEAR)"

check:
	@echo "$(MAGENTA)📦 Verificando entorno y secretos...$(CLEAR)"
	@bash ./scripts/check_secrets.sh
	@bash ./scripts/check_env.sh

build:
	@printf "$(CYAN)🔧 Construyendo contenedores $(CLEAR)\n"
	@spinner="|/-\\"; \
	i=0; \
	while [ $$i -lt 10 ]; do \
		index=`expr $$i % 4`; \
		printf "$(YELLOW)\r$$(echo $$spinner | cut -c $$((index+1)))$(CLEAR)"; \
		sleep 0.1; \
		i=`expr $$i + 1`; \
	done; \
	printf "\r"
	@$(COMPOSE) build
	@echo "$(GREEN)✅ Build completado$(CLEAR)"

up:
	@echo "$(BLUE)🚀 Levantando contenedores...$(CLEAR)"
	@$(COMPOSE) up -d
	@echo "$(GREEN)✅ Contenedores arriba$(CLEAR)"

logs:
	@echo "$(GRAY)📜 Logs en vivo...$(CLEAR)"
	@$(COMPOSE) logs -f

down:
	@echo "$(RED)🛑 Deteniendo contenedores...$(CLEAR)"
	@$(COMPOSE) down
	@echo "$(GREEN)✅ Contenedores detenidos$(CLEAR)"

clean:
	@echo "$(YELLOW)🧹 Limpiando contenedores y volúmenes...$(CLEAR)"
	@$(COMPOSE) down -v --remove-orphans
	@echo "$(GREEN)✅ Limpieza completada$(CLEAR)"

fclean: clean
	@echo "$(RED)🔥 Limpieza total...$(CLEAR)"
	@docker system prune -af
	@docker volume prune -f
	@echo "$(GREEN)✅ Full clean completado$(CLEAR)"

re: fclean all

.PHONY: all check check_ports build up logs down clean fclean re

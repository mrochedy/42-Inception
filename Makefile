CMD = docker-compose
FLAGS = -f
COMPOSE_PATH = ./srcs/docker-compose.yml

WP_DATA = /home/$(USER)/data/web
DB_DATA = /home/$(USER)/data/mariadb

all: up

up:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) build
	@mkdir -p $(WP_DATA) $(DB_DATA)
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) up -d

stop:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) stop

start:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) start

logs:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) logs

fclean:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) down --volumes --remove-orphans
	@docker rmi -f mariadb:user nginx:user wordpress:user redis:user ftp:user staticpage:user adminer:user portainer:user || true
	@sudo rm -rf $(WP_DATA) $(DB_DATA)

re: fclean up

.PHONY: all up stop start logs fclean re

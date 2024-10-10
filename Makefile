CMD = docker-compose
FLAGS = -f
COMPOSE_PATH = ./srcs/docker-compose.yml

WEB_DATA = /home/mrochedy/data/web
DB_DATA = /home/mrochedy/data/mariadb

all: up

up:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) build
	@mkdir -p $(WEB_DATA) $(DB_DATA)
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) up -d

stop:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) stop

start:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) start

logs:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) logs

fclean:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) down --volumes --remove-orphans
	@docker rmi -f mariadb:latest nginx:latest wordpress:latest redis:latest ftp:latest staticpage:latest adminer:latest portainer:latest || true
	@sudo rm -rf $(WEB_DATA) $(DB_DATA)

re: fclean up

.PHONY: all up stop start logs fclean re

CMD = docker-compose
FLAGS = -f
COMPOSE_PATH = ./srcs/docker-compose.yml

WP_DATA = /home/$(USER)/data/wordpress
DB_DATA = /home/$(USER)/data/mariadb

all: up

up: build
	@mkdir -p $(WP_DATA) $(DB_DATA)
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) up -d

down:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) down

stop:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) stop

start:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) start

build:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) build

logs:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) logs

clean:
	@$(CMD) $(FLAGS) $(COMPOSE_PATH) down --volumes --remove-orphans
	@docker rmi -f mariadb:user nginx:user wordpress:user || true
	@sudo rm -rf $(WP_DATA) $(DB_DATA)

re: clean up

.PHONY: all up down stop start build logs clean re

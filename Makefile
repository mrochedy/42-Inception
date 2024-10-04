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

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) $(DB_DATA)

re: clean up

prune: clean
	@docker system prune -a --volumes -f

.PHONY: all up down stop start build clean re prune

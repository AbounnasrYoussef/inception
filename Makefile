NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/yabounna/data/mariadb
	@mkdir -p /home/yabounna/data/wordpress
	docker compose -f $(COMPOSE_FILE) up --build

down:
	docker compose -f $(COMPOSE_FILE) down

stop:
	docker compose -f $(COMPOSE_FILE) stop

start:
	docker compose -f $(COMPOSE_FILE) start

clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all --volumes

fclean: clean
	@sudo rm -rf /home/yabounna/data/wordpress/*
	@sudo rm -rf /home/yabounna/data/mariadb/*
	@docker system prune -a --volumes -f

re: fclean all

.PHONY: all up down stop start clean fclean re

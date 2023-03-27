COMPOSE = ./srcs/docker-compose.yml

all:
	docker-compose -f $(COMPOSE) up -d --build --remove-orphans

status:
	docker-compose -f $(COMPOSE) ps

stop:
	docker-compose -f $(COMPOSE) stop
rm:
	docker-compose -f $(COMPOSE) rm -f

clean: stop
	docker system prune -af

re: clean all

.PHONY: all stop rm re clean

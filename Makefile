dc = docker-compose -f
path = ./srcs/docker-compose.yml


all:
	$(dc) $(path) up -d --build

down:
	$(dc) $(path) down

clean:
	$(dc) $(path) down

fclean: clean
	docker system prune -a --volumes

re:
	clean all

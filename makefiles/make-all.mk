build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down --remove-orphans

start: up

stop: down

restart: stop start

reset: down build up yarn-install bundle-install db-reset

provision: reset db-seed

gen-schema:
	docker-compose exec backend rails graphql:dump_schema
	cp ./backend/config/schema.json ./frontend/schema.json
	docker-compose exec frontend yarn run generate-schema
	rm ./backend/config/schema.json

up:
	docker-compose up -d

down:
	docker-compose down --remove-orphans

start: up

stop: down

restart: stop start

provision: build seed

build:
	docker-compose down --remove-orphans
	docker-compose build
	docker-compose up -d
	docker-compose exec backend bundle install
	docker-compose exec backend rails db:drop db:create db:migrate

gen-schema:
	docker-compose exec backend rails graphql:dump_schema
	cp ./backend/config/schema.json ./frontend/schema.json
	docker-compose exec frontend yarn run generate-schema
	rm ./backend/config/schema.json

up:
	docker-compose up -d backend db redis frontend

down:
	docker-compose down --remove-orphans

start: up bind

stop: down

restart: stop start

provision: build seed

build:
	docker-compose down --remove-orphans
	docker-compose build
	docker-compose up -d
	docker-compose exec backend bundle install
	docker-compose exec backend rails db:drop db:create db:migrate

upg:
	docker-compose run backend bundle update

seed:
	docker-compose exec backend rails db:seed

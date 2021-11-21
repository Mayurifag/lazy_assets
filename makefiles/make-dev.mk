gen-schema:
	docker-compose exec backend rails graphql:dump_schema
	cp ./backend/config/schema.json ./frontend/schema.json
	docker-compose exec frontend yarn run generate-schema
	rm ./backend/config/schema.json

front-sh:
	docker-compose exec frontend bash

back-sh:
	docker-compose exec backend bash

yarn:
	docker-compose exec frontend yarn $(ARGS)

bundle:
	docker-compose exec backend bundle $(ARGS)

rubocop-fix:
	docker-compose exec backend bundle exec standardrb -a

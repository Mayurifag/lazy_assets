front-sh:
	docker-compose exec frontend bash

yarn:
	docker-compose exec frontend yarn $(ARGS)

yarn-add-dev:
	docker-compose exec frontend yarn add -D $(ARGS)

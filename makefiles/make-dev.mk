gen-schema:
	docker-compose exec backend rails graphql:dump_schema
	cp ./backend/config/schema.json ./frontend/schema.json
	docker-compose exec frontend yarn run generate-schema
	rm ./backend/config/schema.json

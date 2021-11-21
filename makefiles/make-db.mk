db: migrate

migrate:
	bin/rails db:migrate

db-reset:
	bin/rails db:drop db:create db:migrate db:seed

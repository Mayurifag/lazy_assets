routes:
	docker-compose run backend rails routes | grep "$(ARGS)"

upg:
	docker-compose run backend bundle update

seed:
	docker-compose exec backend rails db:seed

rg:
	docker-compose exec backend rails generate $(ARGS)

rc:
	docker-compose exec backend rails console

rspec:
	RAILS_ENV=test docker-compose run backend bundle exec rspec $(ARGS)

cred:
	EDITOR=vim docker-compose exec backend rails credentials:edit

db: migrate

migrate:
	bin/rails db:migrate

db-reset:
	bin/rails db:drop db:create db:migrate db:seed

bundle:
	docker-compose exec backend bundle $(ARGS)

rubocop-fix:
	docker-compose exec backend bundle exec standardrb -a

back-sh:
	docker-compose exec backend bash

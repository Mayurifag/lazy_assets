routes:
	docker-compose run backend rails routes | grep "$(ARGS)"

upg:
	docker-compose run backend bundle update

rg:
	docker-compose exec backend rails generate $(ARGS)

rc:
	docker-compose exec backend rails console

rspec:
	RAILS_ENV=test docker-compose run backend bundle exec rspec $(ARGS)

cred:
	EDITOR=vim docker-compose exec backend rails credentials:edit

db-rollback:
	docker-compose exec backend rails db:rollback

db-migrate:
	docker-compose exec backend rails db:migrate

db-seed:
	docker-compose exec backend rails db:seed

db-reset: db-set-development
	docker-compose exec backend rails db:drop db:create db:migrate

db-set-development:
	docker-compose exec backend rails db:environment:set RAILS_ENV=development

bundle:
	docker-compose exec backend bundle $(ARGS)

rubocop-fix:
	docker-compose exec backend bundle exec standardrb -a

back-sh:
	docker-compose exec backend bash

bundle-install:
	docker-compose exec backend bundle install

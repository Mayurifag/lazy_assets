routes:
	docker-compose run backend rails routes | grep "$(ARGS)"

upg:
	docker-compose run backend bundle update

seed:
	docker-compose exec backend rails db:seed

rc:
	docker-compose exec backend rails console

rspec:
	RAILS_ENV=test docker-compose run backend bundle exec rspec $(ARGS)

cred:
	EDITOR=vim docker-compose exec backend rails credentials:edit

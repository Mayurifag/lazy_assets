routes:
	docker-compose run backend rails routes | grep "$(ARGS)"

upg:
	docker-compose run backend bundle update

seed:
	docker-compose exec backend rails db:seed

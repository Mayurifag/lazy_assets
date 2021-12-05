postgres-logs:
	docker-compose logs --tail=1000 -f db

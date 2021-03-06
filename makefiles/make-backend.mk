rails:
	docker-compose exec backend bundle exec rails $(ARGS)

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

db-recreate:
	docker-compose exec backend rails db:drop db:create db:migrate

db-seed:
	docker-compose exec backend rails db:seed

clean-storage:
	rm -rf ./backend/storage/*
	touch ./backend/storage/.keep

db-reset: db-set-development clean-storage db-recreate

db-set-development:
	docker-compose exec backend rails db:environment:set RAILS_ENV=development

bundle:
	docker-compose exec backend bundle $(ARGS)

rubocop-fix:
	docker-compose exec backend bundle exec standardrb -a

bundle-install:
	docker-compose exec backend bundle install

ord:
	docker-compose exec backend bundle exec ordinare

backend-sh:
	docker-compose exec backend sh

# gen-grpc-ruby:
# 	docker run --rm -v $(shell pwd):/mnt memominsk/protobuf-alpine:latest --grpc_out=./backend/app/rpc --ruby_out=./backend/app/rpc /mnt/proto/AssetSymbols.proto
#
#  	docker-compose run backend grpc_tools_ruby_protoc -I /proto/ --ruby_out=/usr/src/app/rpc/proto --grpc_out=/usr/src/app/rpc/proto /proto/AssetSymbols.proto

gen-grpc-ruby:
	mkdir -p ./backend/app/rpc/proto
	docker run --rm \
		-v $(shell pwd):$(shell pwd) \
		-w $(shell pwd) \
		znly/protoc \
		--plugin=protoc-gen-grpc=/usr/bin/grpc_ruby_plugin \
		--ruby_out=./backend/app/rpc/proto \
		--grpc_out=./backend/app/rpc/proto \
		-I ./proto/ \
		./proto/*.proto

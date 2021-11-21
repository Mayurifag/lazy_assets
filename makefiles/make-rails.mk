server:
	-@ rm tmp/pids/server.pid
	bin/rails s -b 0.0.0.0

s: server

c:
	rails c

g:
	rails g $(ARGS)

routes:
	bin/rails routes | grep "$(ARGS)"

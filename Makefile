BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

.PHONY: app test spec lib docs bin config db tmp

ARGS = $(filter-out $@,$(MAKECMDGOALS))

%:
	@:

include ./makefiles/*.mk

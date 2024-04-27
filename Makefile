.PHONY: list
list:
	@grep '^[^#^(PHONY:.*)[:space:]].*:' Makefile | sed 's/://g'

.PHONY: init
init:
	@./init.sh


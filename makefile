.PHONY: test

test:
	@echo Running tests... && \
	RUBYLIB=./lib cutest test/*_test.rb

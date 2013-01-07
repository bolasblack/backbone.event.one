coffeeDir = ./node_modules/coffee-script/bin/coffee

define compile
	$(coffeeDir) -o ./test/js/ ./test/spec/
	$(coffeeDir) -o ./lib/ ./src/
endef

build :
	$(compile)

test :
	$(compile)
	grunt test

.PHONY: test build

.PHONY: MAIN

MAIN:
	@cobc -x MAIN.COB

CLIENTS:
	@cobc -x CLIENTS.COB

clean:
	@rm -rf MAIN
	@rm -rf MAIN.so
	@rm -rf CLIENTS
	@rm -rf CLIENTS.so

run:
	./MAIN
	./CLIENTS

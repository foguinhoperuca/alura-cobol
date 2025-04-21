.PHONY: MAIN

clean:
	@clear
	@rm -rf MAIN
	@rm -rf MAIN.so
	@rm -rf CLIENTS
	@rm -rf CLIENTS.so

MAIN: clean 
	cobc -x MAIN.COB

CLIENTS: clean 
	cobc -x CLIENTS.COB

run-main: MAIN
	@./MAIN

run-client: CLIENTS
	@./CLIENTS

run: run-main run-clients

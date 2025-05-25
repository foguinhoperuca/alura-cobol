.PHONY: run

clean:
	@clear
	@rm -f MAIN
	@rm -f MAIN.so
	@rm -f CLIENTS
	@rm -f CLIENTS.so
	@rm -f *~

MAIN: clean 
	cobc -x MAIN.COB

CLIENTS: clean 
	cobc -x CLIENTS.COB

run-main: MAIN
	@echo "=================="
	@echo "|| Running MAIN ||"
	@echo "=================="
	@./MAIN

run-clients: CLIENTS
	@echo "------------------"
	@echo "| Running CLIENT |"
	@echo "------------------"
	@./CLIENTS

run: run-main run-clients

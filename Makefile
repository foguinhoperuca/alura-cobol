.PHONY: run

clean:
	@clear
	@rm -f bin/MAIN
	@rm -f bin/MAIN.so
	@rm -f bin/CLIENTS
	@rm -f bin/CLIENTS.so
	@rm -f bin/CRM
	@rm -f bin/CRM.so
	@rm -f *~

MAIN: clean 
	cobc -x -o bin/MAIN MAIN.COB

CLIENTS: clean 
	cobc -x -o bin/CLIENT CLIENTS.COB

CRM: clean 
	cobc -x -o bin/CRM CRM.COB

run-crm: CRM
	@echo "=================="
	@echo "|| Running MAIN ||"
	@echo "=================="
	@./bin/CRM

run-main: MAIN
	@echo "=================="
	@echo "|| Running MAIN ||"
	@echo "=================="
	@./bin/MAIN

run-clients: CLIENTS
	@echo "------------------"
	@echo "| Running CLIENT |"
	@echo "------------------"
	@./bin/CLIENTS

run: run-main run-clients


default: help

.PHONY: help
help:
	@echo "Tasks:"
	@echo "make build      -Build a sample repo and checkout"
	@echo "make clean      -Cleanup"



.PHONY: clean
clean:
	rm -rf thecheckout* therepo*

.PHONY: build
build: clean
	./create_tgz.sh


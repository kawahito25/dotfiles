.PHONY: fmt 
fmt:
	stylua --indent-type spaces --collapse-simple-statement Always .

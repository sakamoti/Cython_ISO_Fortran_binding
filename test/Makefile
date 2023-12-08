
main:
	$(MAKE) --directory f_lib 
	$(MAKE) --directory f_main 
	$(MAKE) --directory c_main 
	$(MAKE) --directory py_main 

clean:
	$(MAKE) --directory f_lib clean
	$(MAKE) --directory f_main clean
	$(MAKE) --directory c_main clean
	$(MAKE) --directory py_main clean


test: main
	./c_main/cmain
	./f_main/main
	python ./py_main/main.py
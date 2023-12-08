FC=gfortran
FCFLAGS= -g
INCLUDE=-I../f_lib/
LIBS=-L../f_lib/ -lfort

main:  main.f90
	$(FC) $(INCLUDE) $(FCFLAGS) -o $@ $^ $(LIBS)

clean:
	$(RM) -rf main *.o *.mod
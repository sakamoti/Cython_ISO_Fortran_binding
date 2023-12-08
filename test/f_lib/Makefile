FC=gfortran
FCFLAGS= -fPIC -g
.PHONY: clean
.SUFFIXES: .f90 .o

libfort.a: libfort.o libfort_cinterfaces.o
	$(AR) -r $@ $^
	$(AR) -t $@

.f90.o:
	$(FC) -c $(FCFLAGS) $<

clean:
	$(RM) *.o *.mod *.a
CC=gcc
CFLAGS=-g
INCLUDE=-I../f_lib
LIBS=-lgfortran -L../f_lib -lfort
.PHONY: clean
.SUFFIXES: .c .o

cmain: main.o
	$(CC) $(CFLAGS) $(INCLUDE) $^ -o $@ $(LIBS)

.c.o:
	$(CC) -c $(CFLAGS) $(INCLUDE) $<

clean:
	$(RM) *.o cmain
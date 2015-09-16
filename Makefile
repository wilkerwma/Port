port: port.l port.y
	bison -d port.y
	mv port.tab.h port.h
	mv port.tab.c port.y.c
	flex port.l
	mv lex.yy.c port.lex.c
	gcc -c port.lex.c -o port.lex.o
	gcc -c port.y.c -o port.y.o
	gcc -o port port.lex.o port.y.o -lm

clean:
	rm port.lex.* port.y.* port


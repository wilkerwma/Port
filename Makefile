port: port.l port.y
	bison -d port.y
	flex port.l
	gcc -o port port.tab.c lex.yy.c -lm

clean:
	rm port.lex.* port.y.* port


port: port.l port.y
	bison -d port.y
	flex port.l
	mv port.tab.h port.h
	g++ -o port port.tab.c lex.yy.c -lm -std=c++11

clean:
	rm port.lex.* port.y.* port

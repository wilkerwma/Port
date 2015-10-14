port: port.l port.y
	bison -d port.y
	flex port.l
	g++ -o port port.tab.c lex.yy.c -lm -std=c++14

clean:
	rm port.lex.* port.y.* port

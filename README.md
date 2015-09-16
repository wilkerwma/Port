# Port
Compilador de PORTUGOL para RUBY, desenvolvido na disciplina de Fundamentos de Compiladores 2015/2

Comandos para a primeira compilação:

	>bison -d Port.y
	>mv Port.tab.h Port.h
	>mv Port.tab.c Port.y.c
	>flex Port.lex
	>mv lex.yy.c Port.lex.c
	>gcc -c Port.lex.c -o Port.lex.o
	>gcc -c Port.y.c -o Port.y.o
	>gcc -o Port Port.lex.o Port.y.o -lfl -lm [ E eventualmente -ll] 

%{
#include "port.h"
#include <stdlib.h>
%}

/* Números*/

branco [ \t]+
digito [0-9]
numero -?{digito}+
exponencial [eE][+-]?{numero}
real {numero}("."{numero})?{exponencial}?

/*Variáveis*/

VARIAVEL [a-z|A-Z]+[a-zA-Z0-9]*

%%
{branco} {/* Não faz nada*/}
{real} {yylval.real = atof(yytext);return NUMBER;
	   }

{VARIAVEL} {yylval.strval = strdup(yytext);return VARIAVEL;}

"=" return RECEBE;
"+" return(MAIS);
"-" return(MENOS);
"*" return(VEZES);
"/" return(DIVIDA);
"^" return(ELEVADO);

"(" return(PARENTESES_ESQ);
")" return(PARENTESES_DIR);
"[" return(COLCHETE_ESQ);
"]" return(COLCHETE_DIR);
"{" return(CHAVES_ESQ);
"}" return(CHAVES_DIR);

"\n" return(FIM);

%%

int yywrap(void){
    return 0;
}

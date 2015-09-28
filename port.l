%{
#include "global.h"
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

VARIAVEL [a-z|A-Z|0-9]*

%%
{branco} {/* Não faz nada*/}
{real} {
		yylval=atof(yytext);
		return(NUMBER);
	   }

"RECEBE" return(RECEBE);
"MAIS" return(MAIS);
"MENOS" return(MENOS);
"VEZES" return(VEZES);
"DIVIDA" return(DIVIDA);
"ELEVADO" return(ELEVADO);
"RAIZ" return(RAIZ);

"(" return(PARENTESES_ESQ);
")" return(PARENTESES_DIR);
"[" return(COLCHETE_ESQ);
"]" return(COLCHETE_DIR);
"{" return(CHAVES_ESQ);
"}" return(CHAVES_DIR);

{VARIAVEL} return(VARIAVEL);
"\n" return(FIM);

%%

int yywrap(void){
    return 0;    
}



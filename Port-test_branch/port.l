%{
#include "global.h"
#include "port.h"
#include <stdlib.h>
%}

branco [ \t]+
digito [0-9]
numero -?{digito}+
exponencial [eE][+-]?{numero}
real {numero}("."{numero})?{exponencial}?
VARIAVEL [a-zA-Z]+

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

"(" return(PARENTESES_ESQUERDO);
")" return(PARENTESES_DIREITO);

{VARIAVEL} return(VARIAVEL);
"\n" return(FIM);

%%

int yywrap(void){
    return 0;  
   
}			  



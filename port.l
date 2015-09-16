%{
#include <stdlib.h>
%}

BRANCO [ \t]+
FUNCAO
FIM
SE
FIMSE
VARIAVEL \^[a-Z]+[1-9]+

%%
 
{white} { /* We ignore white characters */ }
"MAIS" return(MAIS);
"MENOS" return(MENOS);
"VEZES" return(VEZES);
"DIVIDIDO" return(DIVIDE);
"ELEVADO" return(ELEVADO);
"(" return(PARENTESES_ESQUERDO);
")" return(PARENTESES_DIREITO);
"\n" return(FIM_DE_LINHA);

%%


yywrap () {
return 0;
}

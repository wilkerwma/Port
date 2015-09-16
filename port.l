%{
#include <stdlib.h>
#include "global.h"
#include "port.h"
%}

BRANCO [ \t]+
/*FUNCAO*/
/*FIM*/
/*SE*/
/*FIMSE*/
MAIS \^MAIS
MENOS \^MENOS
DIVIDA \^DIVIDA
VEZES \^VEZES
ELEVADO \^ELEVADO
VARIAVEL \^[a-Z]+[1-9]+

%%
 
{BRANCO} { /* We ignore white characters */ }
{MAIS} return(MAIS);
{MENOS} return(MENOS);
{VEZES} return(VEZES);
{DIVIDA} return(DIVIDE);
{ELEVADO} return(ELEVADO);
"(" return(PARENTESES_ESQUERDO);
")" return(PARENTESES_DIREITO);

%%


yywrap () {
return 0;
}

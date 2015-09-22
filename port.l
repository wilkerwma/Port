%{
#include <stdlib.h>
#include "global.h"
#include "port.h"
%}

BRANCO [ \t]+
DIGITO [0-9]
INTEIRO {DIGITO}+
/*FUNCAO*/
/*SE*/
/*FIMSE*/
/*MAIS \MAIS*/
/*MENOS \MENOS*/
/*DIVIDA \DIVIDA*/
/*VEZES \VEZES*/
/*ELEVADO \ELEVADO*/
/*VARIAVEL \w*/
%%
 
{BRANCO} { /* We ignore white characters */ }
"+"  return(MAIS);
"-" return(MENOS);
"*" return(VEZES);
"/" return(DIVIDA);
"(" return(PARENTESES_ESQUERDO);
")" return(PARENTESES_DIREITO);
"\n" return(FIM);
%%

int yywrap(void){
    return 0;    
}


%{
#include "port.h"
#include <cstdlib>
%}

/* Números*/

branco [ \t]+
digito [0-9]
numero -?{digito}+
exponencial [eE][+-]?{numero}
real {numero}("."{numero})?{exponencial}?
string "\w*"
FUNCAO [a-z]+[a-zA-Z0-9]* 
VARIAVEL [a-z|A-Z]+[a-zA-Z0-9]*

%%

"RECEBE" return(RECEBE);
"MAIS" return(MAIS);
"MENOS" return(MENOS);
"VEZES" return(VEZES);
"DIVIDA" return(DIVIDA);
"ELEVADO" return(ELEVADO);

"SE" return(SE);
"SENAO" return(SENAO);
"ENTAO" return (ENTAO);

"MAIOR" return (MAIOR);
"MENOR" return (MENOR);
"IGUAL" return (IGUAL);
"DIFERENTE" return (DIFERENTE);

"PARA" return (PARA);
"ENQUANTO" return(ENQUANTO);
"FACA" return (FACA);
"ATE" return (ATE);
"FIM" return (FIM);
"EM" return (EM);

"DEFINA" return (DEFINA);

"(" return(PARENTESES_ESQ);
")" return(PARENTESES_DIR);
"[" return(COLCHETE_ESQ);
"]" return(COLCHETE_DIR);
"{" return(CHAVES_ESQ);
"}" return(CHAVES_DIR);
"," return (VIRGULA);

{branco} {/* Não faz nada*/}

{real} {yylval.real = atof(yytext);return NUMBER;}
{FUNCAO} {yylval.strfunc = strdup(yytext); return FUNCAO;}
{VARIAVEL} {yylval.strval = strdup(yytext);return VARIAVEL;}



%%

int yywrap(void){
    return 0;
}

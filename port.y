%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%token NUMBER
%token MAIS MENOS VEZES DIVIDA
%token RECEBE
%token VARIAVEL
%token FIM


%left MAIS MENOS
%left VEZES DIVIDA

%start Input
%%

Input: 
  /*Empty*/
  | Input Linha
  ;

Linha: 
  FIM
  | Expressao FIM {printf("Resultado: %f\n", $1);}
  | error FIM {yyerrok;}
  ;

Expressao:
  NUMBER  {$$=$1;}
  | VARIAVEL {$$=$1;}
  | Expressao RECEBE Expressao {$$ = $3;}
  | Expressao MAIS Expressao {$$ = $1 + $3;}
  | Expressao MENOS Expressao {$$ = $1 - $3;}
  | Expressao VEZES Expressao {$$ = $1 * $3;}
  | Expressao DIVIDA Expressao {$$ = $1 / $3;}
  ;

%%

int yyerror(char *s){
  printf("%s\n", s);
}  

int main(void) {
  yyparse();
}
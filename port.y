%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}


%token NUMBER
%token MAIS MENOS VEZES DIVIDA ELEVADO RAIZ


%token RECEBE
%token PARENTESES_ESQ PARENTESES_DIR COLCHETE_ESQ COLCHETE_DIR CHAVES_ESQ CHAVES_DIR 

%token VARIAVEL
%token FIM


%left MAIS MENOS
%left NEG  
%left VEZES DIVIDA

%right ELEVADO

%start Input
%%

Input: 
  /*Empty*/
  | Input Linha
  ;

Linha: 
  FIM
  | Expressao FIM {printf("\nResultado: %f\n", $1);}
  | error FIM {yyerrok;}
  ;

Expressao:
  NUMBER  {$$=$1;}
  | VARIAVEL {$$=$1;}
  | Expressao RECEBE Expressao {$$ = $3; printf("%f = %f", $1,$3);}
  | Expressao MAIS Expressao {$$ = $1 + $3;printf("%f + %f", $1,$3);}
  | Expressao MENOS Expressao {$$ = $1 - $3;printf("%f - %f", $1,$3);}
  | Expressao VEZES Expressao {$$ = $1 * $3;printf("%f * %f", $1,$3);}
  | Expressao DIVIDA Expressao {$$ = $1 / $3;printf("%f / %f", $1,$3);}
  | Expressao ELEVADO Expressao {$$ = pow($1,$3);printf("%f ** %f", $1,$3);}
  | MENOS Expressao %prec NEG {$$ = -$2;printf("-%f", $2);}
  | PARENTESES_ESQ Expressao PARENTESES_DIR {$$ = $2;printf("(%f)", $2);}
  | COLCHETE_ESQ Expressao COLCHETE_DIR {$$ = $2;$$ = $2;printf("[%f]", $2);}
  | CHAVES_ESQ Expressao CHAVES_DIR {$$ = $2;$$ = $2;printf("{%f}", $2);}

  ;

%%

int yyerror(char *s){
  printf("%s\n", s);
}  

int main(void) {
  yyparse();
}
%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "global.h"
%}


%token MAIS MENOS VEZES DIVIDA ELEVADO 
%token PARENTESES_DIREITO PARENTESES_ESQUERDO
%token IMPRIMA COLOQUE
%token VARIAVEL
%token NUMERO
%token FIM
%token RETORNE
%left MAIS MENOS VEZES DIVIDA
%left NEGATIVO
%right ELEVADO
%start Input
%%

Input: 
    | Input Linha
    ;

Linha:
       FIM  
    | Expressao FIM {printf("Resultado: %f \n",$1);}
    | error FIM {yyerrok;}
    ;

Expressao: 
            NUMERO { $$=$1; }
          | Expressao '+' Expressao { $$=$1+$3; }
          | Expressao MENOS Expressao {$$ = $1 - $3;}
          | Expressao VEZES Expressao {$$ = $1 * $3;}
          | Expressao DIVIDA Expressao {$$ = $1 / $3;}
          | Expressao ELEVADO Expressao {$$ =pow($1,$3);}
          | PARENTESES_ESQUERDO Expressao PARENTESES_DIREITO {$$ = $2;}
          ;

%%
int yyerror(char *s){
    printf("Erro: %s\n",s);
}

int main(void){
    yyparse();
}

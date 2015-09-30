%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

char buffer[10];

%}

%union {
	float real;
	char *strval;
}
%token <real> NUMBER
%token MAIS MENOS VEZES DIVIDA ELEVADO RAIZ

%token  RECEBE
%token  PARENTESES_ESQ PARENTESES_DIR COLCHETE_ESQ COLCHETE_DIR CHAVES_ESQ CHAVES_DIR

%token <strval> VARIAVEL
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
  | Expressao FIM
  | Atribuicao FIM
  | error FIM {yyerrok;}
  ;

Expressao:
  NUMBER
  | VARIAVEL
  | Expressao MAIS Expressao
  | Expressao MENOS Expressao
  | Expressao VEZES Expressao
  | Expressao DIVIDA Expressao
  | Expressao ELEVADO Expressao
  | MENOS Expressao %prec NEG
  | PARENTESES_ESQ Expressao PARENTESES_DIR
  | COLCHETE_ESQ Expressao COLCHETE_DIR
  | CHAVES_ESQ Expressao CHAVES_DIR
  ;

  Atribuicao:
    VARIAVEL RECEBE NUMBER {sprintf(buffer,"%f",$3);$1 = buffer;printf("%s\n",$1);}
    ;


%%
int yyerror(char *s){
  printf("%s\n", s);
}

int main(void) {
  yyparse();
}

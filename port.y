%{
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstring>
#include <map>

#include "port.h"

using namespace std;
char buffer[10];
map<char*,float> variables;
extern char* yytext;
/*int linha = 0;
int saida = NULL;
FILE *file;*/
int yylex(void);
void yyerror(const char *);
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
%}

%union {
	float real;
	char *strval;
}

%token <real> NUMBER
%token MAIS MENOS VEZES DIVIDA ELEVADO RAIZ

%token  RECEBE
%token  PARENTESES_ESQ PARENTESES_DIR COLCHETE_ESQ COLCHETE_DIR CHAVES_ESQ CHAVES_DIR
%type <real> Expressao
%token <strval> VARIAVEL
%token FIM

%left VEZES DIVIDAchar
%left MAIS MENOS
%left NEG

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
  NUMBER {sprintf(buffer,"%f",$1);}
  | VARIAVEL {sprintf(buffer,"%f",$1);}
  | Expressao MAIS Expressao {sprintf(buffer,"%f",$1+$3);cout<<buffer<< endl;}
  | Expressao MENOS Expressao
  | Expressao VEZES Expressao
  | Expressao DIVIDA Expressao
  | Expressao ELEVADO Expressao
  ;

  Atribuicao:
    VARIAVEL RECEBE Expressao {variables.insert(pair<char*,float>($1,$3));}
    ;


%%

int main(void) {

  yyparse();


}

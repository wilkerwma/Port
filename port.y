%{
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstring>
#include <map>
#include <vector>
#include <sstream>
#include "port.h"

using namespace std;
char buffer[10];
map<string,float> variables;
vector<string> saida;
extern char* yytext;
ostringstream ss;
/*int linha = 0;
int saida = NULL;
FILE *file;*/
int yylex(void);
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }

void printmap(map<string,float> mymap){
  for(auto& iterator : mymap){
    cout << iterator.first << " " << iterator.second << endl;
  }
}

void printsaida(vector<string> myvector){
  for(auto& iterator : myvector){
    cout << iterator.front();
  }
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
    VARIAVEL RECEBE Expressao {ss << $3; string s(ss.str());variables.insert(pair<string,float>($1,$3));saida.push_back($1);
      saida.push_back("=");saida.push_back(s);printmap(variables); printsaida(saida);}
    ;


%%

int main(void) {

  yyparse();


}

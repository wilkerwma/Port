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
map<string,float> variablesMap;
vector<string> saida;
extern char* yytext;
ostringstream ss;
int yylex(void);
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }

void printmap(map<string,float> mymap){
  for(auto& iterator : mymap){
    cout << iterator.first << " " << iterator.second << endl;
  }
}

bool checkmap(map<string,float> &mymap, string variable){
	bool checker = NULL;
	for(auto& iterator : mymap)
		checker = iterator.first == variable? true : false;
	return checker;
	
}

void insertVariable(map<string, float> &mymap, string variable, float value){
	if(checkmap(mymap, variable)){
		cout << "Warning: variable "<< variable <<" already declared,overwriting value" <<endl;
		mymap[variable] = value;	
	}else{
		cout << "Inserting variable into map" << endl;
		mymap.insert(pair<string,float>(variable,value));			
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

%left VEZES DIVIDA
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
  NUMBER {$$ = $1;}
  | VARIAVEL
  | Expressao MAIS Expressao {$$ = $1 + $3;}
  | Expressao MENOS Expressao {$$ = $1 - $3;}
  | Expressao VEZES Expressao {$$ = $1 * $3;}
  | Expressao DIVIDA Expressao {$$ = $1 / $3;}
  | Expressao ELEVADO Expressao {$$ = pow($1,$3);}
  ;

  Atribuicao:
    VARIAVEL RECEBE Expressao {ss << $3; string s(ss.str());insertVariable(variablesMap,$1,$3);saida.push_back($1);
      saida.push_back("=");saida.push_back(s);printmap(variablesMap); printsaida(saida);}
    ;


%%

int main(void) {

  yyparse();


}

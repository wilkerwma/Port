%{
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstring>
#include <map>
#include <vector>
#include <sstream>
#include <fstream>
#include "port.h"

using namespace std;
ofstream rubyfile;
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
  rubyfile.open("port.rb", fstream::out);
	for(auto& iterator : myvector){
    rubyfile << iterator;
  }
	rubyfile.close();
}

string convertNumber(float number){
	ss.str("");
	ss << number;
	string s(ss.str());
	return s;
}
%}

%union {
	float real;
	char *strval;
}

%token <real> NUMBER
%token MAIS MENOS VEZES DIVIDA ELEVADO RAIZ
%token SE SENAO MAIOR MENOR IGUAL DIFERENTE
%token  RECEBE
%token  PARENTESES_ESQ PARENTESES_DIR COLCHETE_ESQ COLCHETE_DIR CHAVES_ESQ CHAVES_DIR
%type <real> Expressao
%type <bool> Comparacao
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
  NUMBER {$$ = $1;saida.push_back(convertNumber($1));saida.push_back("\n");}
  | Expressao MAIS Expressao {$$ = $1 + $3; saida.push_back(convertNumber($1)); saida.push_back("+"); saida.push_back(convertNumber($3));saida.push_back("\n");}
  | Expressao MENOS Expressao {$$ = $1 - $3;saida.push_back(convertNumber($1)); saida.push_back("-"); saida.push_back(convertNumber($3));saida.push_back("\n");}
  | Expressao VEZES Expressao {$$ = $1 * $3;saida.push_back(convertNumber($1)); saida.push_back("*"); saida.push_back(convertNumber($3));saida.push_back("\n");}
  | Expressao DIVIDA Expressao {$$ = $1 / $3;saida.push_back(convertNumber($1)); saida.push_back("/"); saida.push_back(convertNumber($3));saida.push_back("\n");}
  | Expressao ELEVADO Expressao {$$ = pow($1,$3);saida.push_back(convertNumber($1)); saida.push_back("**"); saida.push_back(convertNumber($3));saida.push_back("\n");}
  ;

Atribuicao:
  VARIAVEL RECEBE Expressao {saida.insert(saida.begin(),"=");saida.insert(saida.begin(),$1);insertVariable(variablesMap,$1,$3);printmap(variablesMap); printsaida(saida);}
    ;

Comparacao:
	Expressao MAIOR Expressao {$$ = $1 > $3;}
  | Expressao IGUAL Expressao {$$ = $1 == $3;}
	| Expressao MENOR Expressao {$$ = $1 < $3;}
	| Expressao DIFERENTE Expressao	{$$ = $1 != $3;}
	; 

Condicional:
	SE Comparacao	Expressao
	;

%%

int main(void) {

  yyparse();
}

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
void printsaida(vector<string> &myvector){
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
%token SE SENAO ENTAO MAIORIGUAL MENORIGUAL MAIOR MENOR IGUAL DIFERENTE
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
  | Condicao FIM
  | error FIM {yyerrok;}
  ;

Expressao:
  NUMBER {$$ = $1;saida.push_back(convertNumber($1));}
  | Expressao MAIS   {saida.push_back("+");} Expressao {$$ = $1 + $4;}
  | Expressao MENOS  {saida.push_back("-");} Expressao {$$ = $1 - $4;}
  | Expressao VEZES  {saida.push_back("*");} Expressao {$$ = $1 * $4;}
  | Expressao DIVIDA {saida.push_back("/");} Expressao {$$ = $1 / $4;}
  | Expressao ELEVADO{saida.push_back("**");}Expressao {$$ = pow($1,$4);}
  ;

Atribuicao:
  VARIAVEL {saida.push_back($1);} RECEBE {saida.push_back("=");} Expressao {saida.push_back("\n");insertVariable(variablesMap,$1,$5);printmap(variablesMap);}
    ;

Statement:
	Expressao
	| Atribuicao
	| Condicao
	;

Comparador:
	IGUAL {saida.push_back("==");}
	| MAIOR{saida.push_back(">");}
	| MENOR{saida.push_back("<");}
	| MAIORIGUAL{saida.push_back(">=");}
	|	MENORIGUAL{saida.push_back("<=");}
	| DIFERENTE{saida.push_back("!=");}
	;

Condicao:
	SE {saida.push_back("if ");} VARIAVEL {saida.push_back($3);} Comparador VARIAVEL {saida.push_back($6);} ENTAO {saida.push_back(" then ");} Statement SENAO {saida.push_back(" else ");} Statement{printsaida(saida);}
	;



%%

int main(void) {

  yyparse();
	printsaida(saida);
}

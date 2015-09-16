%{
#include <iostream>
#include <cmath>
#include <stdlib>
%}


%token MAIS MENOS VEZES DIVIDE ELEVADO 
%token PARENTESES_DIREITO PARENTESES_ESQUERDO
%token IMPRIMA COLOQUE
%token VARIAVEL
%token FIM
%token RETORNE

%left MAIS MENOS VEZES DIVIDE
%left NEGATIVO
%right ELEVADO

%%

Input:
     | Input Linha
     ;

Linha: FIM
    | COLOQUE VARIAVEL FIM {std::cout << $2 << endl;}
    | IMPRIMA VARIAVEL FIM {std::cout << $2;}
    | Expressao FIM
    | error FIM {yyerror;}
    ;

Expressao: VARIAVEL
          | Expressao MAIS Expressao {$$ = $1 + $3}
          | Expressao MENOS Expressao {$$ = $1 - $3}
          | Expressao VEZES Expressao {$$ = $1 * $3}
          | Expressao DIVIDE Expressao {$$ = $1 / $3}
          | Expressao ELEVADO Expressao {$$ =pow($1,$3)}
          | PARENTESES_ESQUERDO Expressao PARENTESES_DIREITO {$$ = $2}
          ;

%%
int yyerror(char *s){
    cout << s << endl;
}

int main(void){
    yyparse();
}

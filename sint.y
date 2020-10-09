%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <math.h>

  int yylex();

  void yyerror(char *s) {
    printf("ERRO: [%s]\n", s);
  }

  typedef struct vars {
		char name[50];
		float value;
		struct vars * prox;
	} VARS;

  // add nova variável na lista
	VARS * ins(VARS*l,char n[]){
		VARS*new =(VARS*)malloc(sizeof(VARS));
		strcpy(new->name,n);
		new->prox = l;
		return new;
	}

  // busca uma variável na lista de variáveis
	VARS *srch(VARS*l,char n[]){
		VARS*aux = l;
		while(aux != NULL){
			if(strcmp(n,aux->name)==0){
				return aux;
			}
			aux = aux->prox;
		}
		return aux;
	}
	
	VARS *l1;
%}

%union{
	float real;
	char texto[50];
}

%token <real>NUMERO_REAL
%token <texto>VARIAVEL
%token <texto>STRING
%token INICIO
%token FIM
%token REAL
%token RAIZ
%token ATRIBUICAO
%token ESCREVER
%token LER

%left '+' '-'
%left '*' '/'

%right '^'
%right NEG

%type <real>exp
%type <real>valor

%%

prog: INICIO cod FIM ;

cod: cod cmdos | ;

cmdos:  decl |

  ESCREVER '(' STRING ')' {
    int i;

    for(i = 0; $3[i] != '\0'; ++i){
      if($3[i] != '\"')
        printf("%c", $3[i]);
    }
    printf ("\n");
  } |

  ESCREVER '(' exp ')' {
    printf("%.2f \n", $3);
  } | 
	
  LER '(' VARIAVEL ')' {
    VARS * aux = srch(l1, $3);
    
    if(aux == NULL) {
      printf ("A variável '%s' não foi declarada\n", $3);
    } else {
      float f;
      printf("> ");
      scanf("%f", &f);
      aux->value = f;
    }
  } |
		
  VARIAVEL ATRIBUICAO exp {
    VARS * aux = srch(l1, $1);
    if (aux == NULL)
      printf ("Variável '%s' não foi declarada\n",$1);
    else {
      aux->value = $3;
    }
  };

decl: 
  REAL VARIAVEL {
    VARS * aux = srch(l1, $2);

    if (aux == NULL)
      l1 = ins(l1, $2);
    else
      printf ("A variável '%s' já existe.\n",$2);

  } | REAL VARIAVEL ATRIBUICAO exp {
    
    VARS * aux = srch(l1, $2);

    if (aux == NULL) {
      l1 = ins(l1, $2);
      aux = srch(l1, $2);
      aux->value = $4;
    } else {
      printf ("A variável '%s' já existe.\n",$2);
    }

  } | REAL VARIAVEL ',' decl {
    VARS * aux = srch(l1, $2);
    if (aux == NULL)
      l1 = ins(l1, $2);
    else
      printf ("A variável '%s' já existe.\n",$2);
  } | VARIAVEL {
    VARS * aux = srch(l1, $1);
    if (aux == NULL)
      l1 = ins(l1, $1);
    else
      printf ("A variável '%s' já existe.\n",$1);
  };


exp: 
  RAIZ '(' exp ')' {
    $$ = sqrt($3);
  } |

  exp '+' exp {
    $$ = $1 + $3;
  } |
  
  exp '-' exp {
    $$ = $1 - $3;
  } |
  
  exp '*' exp {
    $$ = $1 * $3;
  } |
  
  exp '/' exp {
    $$ = $1 / $3;
  } |
  
  '(' exp ')' {
    $$ = $2;
  } |
  
  exp '^' exp {
    $$ = pow($1, $3);
  } |
  
  '-' exp %prec NEG {
    $$ = -$2;
  } |

  valor {
    $$ = $1;
  } |

  VARIAVEL {
    VARS * aux = srch(l1,$1);
    if (aux == NULL)
      printf ("Variável '%s' não foi declarada.\n",$1);
    else
      $$ = aux->value;
};

valor: NUMERO_REAL {
  $$ = $1;
};

%%

#include "lex.yy.c"

int main() {
  l1 = NULL;

  yyin = fopen("in.sena", "r");
  yyparse();
  yylex();
  fclose(yyin);
  
  return 0;
}
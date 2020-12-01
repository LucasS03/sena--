%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <math.h>

  #define TYPE_INT "INT"
  #define TYPE_FLOAT "FLOAT"
  #define TYPE_STRING "STRING"

  int yylex();

  void yyerror(char *s) {
    printf("ERRO: [%s]\n", s);
  }

  typedef struct vars {
    char type[10];
		char name[50];

		float vfloat;
    int vint;
    char vstring[200];

		struct vars * prox;
	} VARS;

  // add nova variável na lista
	VARS * ins(VARS*l, char n[], char type[]){
		VARS *new = (VARS*) malloc(sizeof(VARS));
		
    strcpy(new->name, n);
    strcpy(new->type, type);

		new->prox = l;
		return new;
	}

  // busca uma variável na lista de variáveis
	VARS *srch(VARS*l,char n[]){
		VARS *aux = l;

		while(aux != NULL){
			if(strcmp(n, aux->name) == 0){
				return aux;
			}

			aux = aux->prox;
		}

		return aux;
	}

  // retorna última variável salva
  VARS *getLastType(VARS *l) {
    VARS *aux = l;
    return aux;
  }

  void println(char str[]) {
    int i;
    for(i = 0; str[i] != '\0'; ++i){
      if(str[i] != '\"')
        printf("%c", str[i]);
    }
    printf("\n");
  }

  void print(char str[]) {
    int i;
    for(i = 0; str[i] != '\0'; ++i){
      if(str[i] != '\"')
        printf("%c", str[i]);
    }
  }
	
	VARS *l1;
%}

%union{
	float real;
  int inteiro;
	char texto[200];
}

%token <real>NUM_REAL
%token <texto>VARIAVEL
%token <texto>STRING
%token INICIO
%token FIM
%token REAL
%token INTEIRO
%token TEXTO
%token RAIZ
%token ATRIBUICAO
%token ESCREVER
%token LER

%left '+' '-'
%left '*' '/'

%right '^'
%right NEG

%type <real>exp

%%

prog: INICIO cod FIM ;

cod: cod cmdos | ;

cmdos:  decl |

  ESCREVER '(' STRING ')' {
    println($3);
  } |

  ESCREVER '(' VARIAVEL ')' {
    VARS * aux = srch(l1, $3);
    
    if (aux != NULL) {

      if(strcmp(aux->type, TYPE_FLOAT) == 0)
        printf("%.2f\n", aux->vfloat);
      if(strcmp(aux->type, TYPE_STRING) == 0)
        println(aux->vstring);
      if(strcmp(aux->type, TYPE_INT) == 0)
        printf("%d\n", aux->vint);
    } else {
      printf("ERRO: A váriavel %s não existe\n", $3);
    }
  } |

  ESCREVER '(' exp ')' {
    // ver como pode verificar o tipo
    printf("%.2f \n", $3);
  } | 
	
  LER '(' VARIAVEL ')' {
    VARS * aux = srch(l1, $3);
    
    if(aux == NULL) {
      printf ("A variável '%s' não foi declarada\n", $3);
    } else {

      float f;
      int i;
      char s[200];
      printf("> ");

      if(strcmp(aux->type, TYPE_FLOAT) == 0) {
        scanf("%f", &f);
        aux->vfloat = f;
      } else if(strcmp(aux->type, TYPE_INT) == 0) {
        scanf("%d", &i);
        aux->vint = i;
      } else {
        scanf("%s", s);
        strcpy(aux->vstring, s);
      }
    }
  } |

  VARIAVEL ATRIBUICAO STRING {
    VARS * aux = srch(l1, $1);

    if (aux == NULL)
      printf ("Variável '%s' não foi declarada\n",$1);
    else 
      strcpy(aux->vstring, $3);
  } |
		
  VARIAVEL ATRIBUICAO exp {
    VARS * aux = srch(l1, $1);

    if (aux == NULL)
      printf ("Variável '%s' não foi declarada\n",$1);
    else {
      if(strcmp(aux->type, TYPE_FLOAT) == 0)
        aux->vfloat = $3;
      else if(strcmp(aux->type, TYPE_INT) == 0)
        aux->vint = $3;
    }
  };

decl: 
  TEXTO VARIAVEL {
    VARS * aux = srch(l1, $2);

    if (aux == NULL)
      l1 = ins(l1, $2, TYPE_STRING);
    else
      printf ("A variável '%s' já existe.\n",$2);

  } | TEXTO VARIAVEL ATRIBUICAO STRING {
    
    VARS * aux = srch(l1, $2);

    if (aux == NULL) {
      l1 = ins(l1, $2, TYPE_STRING);
      aux = srch(l1, $2);
      strcpy(aux->vstring, $4);
    } else {
      printf ("A variável '%s' já existe.\n",$2);
    }

  } | TEXTO VARIAVEL ',' decl {
    VARS * aux = srch(l1, $2);

    if (aux == NULL)
      l1 = ins(l1, $2, TYPE_STRING);
    else
      printf ("A variável '%s' já existe.\n",$2);
  } | 

  REAL VARIAVEL {
    VARS * aux = srch(l1, $2);

    if (aux == NULL)
      l1 = ins(l1, $2, TYPE_FLOAT);
    else
      printf ("A variável '%s' já existe.\n",$2);

  } | REAL VARIAVEL ATRIBUICAO exp {
    
    VARS * aux = srch(l1, $2);

    if (aux == NULL) {
      l1 = ins(l1, $2, TYPE_FLOAT);
      aux = srch(l1, $2);
      aux->vfloat = $4;
    } else {
      printf ("A variável '%s' já existe.\n",$2);
    }

  } | REAL VARIAVEL ',' decl {
    VARS * aux = srch(l1, $2);
    if (aux == NULL)
      l1 = ins(l1, $2, TYPE_FLOAT);
    else
      printf ("A variável '%s' já existe.\n",$2);
  } | INTEIRO VARIAVEL {
    VARS * aux = srch(l1, $2);

    if (aux == NULL)
      l1 = ins(l1, $2, TYPE_INT);
    else
      printf ("A variável '%s' já existe.\n",$2);

  } | INTEIRO VARIAVEL ATRIBUICAO exp {
    
    VARS * aux = srch(l1, $2);

    if (aux == NULL) {
      l1 = ins(l1, $2, TYPE_INT);
      aux = srch(l1, $2);

      aux->vint = (int)$4;
    } else {
      printf ("A variável '%s' já existe.\n", $2);
    }

  } | INTEIRO VARIAVEL ',' decl {
    VARS * aux = srch(l1, $2);
    if (aux == NULL)
      l1 = ins(l1, $2, TYPE_INT);
    else
      printf ("A variável '%s' já existe.\n",$2);
  } | VARIAVEL {
    VARS * aux = srch(l1, $1);
    if (aux == NULL) {
      aux = getLastType(l1);
      l1 = ins(l1, $1, aux->type);
    } else
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

  NUM_REAL {
    $$ = $1;
  } | 

  VARIAVEL {
    VARS * aux = srch(l1,$1);
    if (aux == NULL)
      printf ("Variável '%s' não foi declarada.\n",$1);
    else {
      if(strcmp(aux->type, TYPE_FLOAT) == 0)
        $$ = aux->vfloat;
      else if(strcmp(aux->type, TYPE_INT) == 0)
        $$ = aux->vint;
      else 
        printf("Variável é String");
    }
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
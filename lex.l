%{
  
%}

INTEIRO "inteiro"
REAL "real"
TEXTO "texto"

LETRA [a-zA-Z]+
NUMERO [0-9]+
NUMERO_REAL [0-9]+\.?[0-9]*
STRING \".*\"
RAIZ "raiz"

VARIAVEL {LETRA}({LETRA}|{NUMERO}|"-"|"_")*
COMENTARIO "@@".*
ATRIBUICAO "<<"

LER "leia"
ESCREVER "escreva"

INICIO "inicio"
FIM "fim"

LOGICO ">"|"<"|"=="
CONDICIONAL "SENAO SE"|"SE"|"SENAO"
REPETICAO "REPETE"
INVALIDO .
%%

{INICIO} {
  return INICIO;
}
{FIM} {
  return FIM;
}

{CONDICIONAL} {
  printf("Apenas léxico. Estrutura condicional: %s\n", yytext);
}
{REPETICAO} {
  printf("Apenas léxico. Estrutura de repeticao: %s\n", yytext);
}
{ATRIBUICAO} {
  return ATRIBUICAO;
}

{INTEIRO} {
  // ...
}
{REAL} {
  return REAL;
}
{TEXTO} {
  // return TEXTO;
}
{RAIZ} {
  return RAIZ;
}
{LER} {
  return LER;
}
{ESCREVER} {
  return ESCREVER;
}
{VARIAVEL} {
  strcpy (yylval.texto,yytext);
  return VARIAVEL;
}

{COMENTARIO} {
  /* ignore */
}

{NUMERO_REAL} {
	yylval.real = atof(yytext);
	return NUMERO_REAL;
}
{STRING} {
  strcpy(yylval.texto, yytext);
	return STRING;
}

[-+()=/*^] {
  return *yytext;
}

{LOGICO} {
  printf("Apenas léxico. Operador lógico: %s\n", yytext);
}

"\n"|" "|"\t" {
  /* ignore */
}
{INVALIDO} {
  /* ignore */
}

%%
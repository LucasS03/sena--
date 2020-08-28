%{
  // Código C

  // bibliotecas
  // funções
  // structs

%}

INTEIRO "inteiro"
REAL "real"
TEXTO "texto"

NUMERO [0-9]+
LETRA [a-zA-Z]+
STRING \".*\"

ARITMETICO "+"|"-"|"*"|"/"
LOGICO ">"|"<"|"=="

COMENTARIO "@@".*

VARIAVEL {LETRA}({LETRA}|{NUMERO}|"-"|"_")*
LER "leia"(" ")*">>"(" ")*{VARIAVEL}
ESCREVERr "escreva"(" ")*"<<"(" ")*\".*\"
ESCREVER "escreva"(" ")*"<<"(" ")*({VARIAVEL}|\".*\")*
CONDICIONAL ("SE"(" ")?"(".+")")|("ELSE")
REPETICAO "REPETE"(" ")?"(".+")"
INVALIDO .

%%

"COMECOU" { printf("Identificador de início do programa: %s\n", yytext); }
"ACABOOOU" { printf("Identificador de fim do programa: %s\n", yytext); }
"\n"|" "|"\t"|","|"<<"|"("|")" { /* ignore */ }

{CONDICIONAL} { printf("Estrutura condicional: %s\n", yytext); }
{REPETICAO} { printf("Estrutura de repeticao: %s\n", yytext); }

{INTEIRO} { printf("Tipo inteiro: %s\n", yytext); }
{REAL} { printf("Tipo real: %s\n", yytext); }
{TEXTO} { printf("Tipo texto: %s\n", yytext); }
{VARIAVEL} { printf("Variável: %s\n", yytext); }

{COMENTARIO} { printf("Comentário: %s\n", yytext); }
{LER} { printf("Operação de leitura: %s\n", yytext); }
{ESCREVER} { printf("Operação de escrita: %s\n", yytext); }

{NUMERO} { printf("Número: %s\n", yytext); }
{STRING} { printf("String: %s\n", yytext); }
{ARITMETICO} { printf("Operador aritmético: %s\n", yytext); }
{LOGICO} { printf("Operador lógico: %s\n", yytext); }

{INVALIDO} { printf("Caractere inválido: %s\n", yytext); }

%%

int main() {
  
  yyin = fopen("in.sena", "r");
  yylex();
  fclose(yyin);

  return 0;
}
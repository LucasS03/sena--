all: lex.l
	flex -i lex.l 
	gcc lex.yy.c -o sena-compilador -lfl
	clear
	./sena-compilador
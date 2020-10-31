all: lex.l sint.y
	flex -i lex.l 
	bison sint.y
	gcc sint.tab.c -o sena-compilador -lfl -lm
	clear
	./sena-compilador
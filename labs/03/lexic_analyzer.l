%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

\/\/	{}
f	{fprintf(yyout, "floatdcl");}
i	{fprintf(yyout, "intdcl");}
p	{fprintf(yyout, "print");}
=	{fprintf(yyout, "assign");}
\+	{fprintf(yyout, "sum");}
\-	{fprintf(yyout, "res");}
\*	{fprintf(yyout, "mul");}
\/	{fprintf(yyout, "div");}
[0-9]+	{fprintf(yyout, "inum");}
[0-9]+.[0-9]+	{fprintf(yyout, "fnum");}
[a-eg-hj-oq-z]+	{fprintf(yyout, "id");}
[\n]	{fprintf(yyout, "\n");}

%%

int main(int argc, char** argv){
	
	FILE *fOut, *fIn;

	if(argc < 2){
		printf("No arguments \n");
		return 1;
	}

	fIn = fopen(argv[1], "r");
	yyin = fIn;

	fOut = fopen("lex.out", "w");
	yyout = fOut;
	
	yylex();

	return 0;
}

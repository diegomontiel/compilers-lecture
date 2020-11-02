%{
#include <stdio.h>
#include <stdlib.h>
%}

%union {
char id;
int integer;
float floatValue;
}

%token assign
%token floatdcl intdcl print ID
%token plus minus inum fnum division multiplication
%left multiplication division
%type <id>ID
%type <integer>inum
%type <floatValue>fnum
%left plus minus

%%

list: /*empty */
        |
      list stat
      {printf("List -> {List, Stat}\n");}

stat:   
        ID assign expr {printf("Stat -> {%c, \"=\", Expr}\n", $1);}
        |
        intdcl ID {printf("Stat -> {intdcl, %c}\n", $2);}
        |       
        floatdcl ID {printf("Stat -> {floatdcl, %c}\n",$2);}
        |
        print ID {printf("Stat -> {print, %c}\n", $2);}
        ;
expr:    '(' expr ')'
        |    
        expr plus expr {printf("Expr -> {Expr, \"+\" Expr}\n");}
        |
        expr minus expr {printf("Expr -> {Expr, \"-\" Expr}\n");}
        |
		expr multiplication expr {printf("Expr -> {Expr, \"*\" Expr}\n");}
        |
        expr division expr {printf("Expr -> {Expr, \"/\" Expr}\n");}
        |   
        ID {printf("Expr -> {%c}\n", $1);}
        |
        number {printf("Expr -> {Number}\n");}
        ;
        
number: inum{printf("Number -> {%d}\n", $1);}
        |
        fnum{printf("Number -> {%f}\n", $1);}
          ;

%%

extern int yylex();
extern int yyparse();
extern FILE *yyin; 


int main(int argc, char** argv) {

  FILE *fileInput = fopen(argv[1], "r");	
  yyin = fileInput;

  printf("digraph D {\n");
	
  while (!feof(yyin)){
	yyparse();
  }

  printf("}\n");

  return 0;
}

yywrap(){
  return(1);
}
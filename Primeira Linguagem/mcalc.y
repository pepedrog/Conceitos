/* Calculadora infixa */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char *oper(char op, char *l, char *r) {
	char *res = malloc(strlen(l)+strlen(r)+6);
	sprintf(res, "(%c %s %s)", op, l, r);
	return res;
}
char *func(char *nome, char *arg) {
	char *res = malloc(strlen(nome)+strlen(arg)+6);
	printf("reconheci uma fnção de nome = %s e arg = %s\n", nome, arg);
	sprintf(res, "(%s %s)", nome, arg);
	return res;
}
char *dup(char *orig) {
	char *res = malloc(strlen(orig)+1);
	strcpy(res,orig);
	return res;
}
int yylex();
void yyerror(char *);
%}

%union {
	char *val;
}

%token	<val> NUM
%token  <val> FUNC
%token  ADD SUB MUL PRINT OPEN CLOSE
%type	<val> exp

%left ADD SUB
%left MUL DIV
%left NEG
%left FUNC
/* Gramatica */
%%

input: 		
		| 		exp     { puts($1);}
		| 		error  	{ fprintf(stderr, "Entrada inválida\n"); }
;

exp: 			NUM 		{ $$ = dup($1); }
		| 		exp ADD exp	{ printf("reconheci $1 = %s\n",$1);$$ = oper('+', $1, $3);}
		| 		exp SUB exp	{ $$ = oper('-', $1, $3);}
		| 		exp MUL exp	{ $$ = oper('*', $1, $3);}
		|		exp DIV exp { $$ = oper('/', $1, $3);}
		| 		SUB exp %prec NEG  { $$ = oper('~', $2, "");} 
		|		FUNC exp { printf("reconheci $1 = %s\n $2 = %s\n", $1, $2);$$ = func($1, $2);}
		| 		OPEN exp CLOSE	{ $$ = dup($2);}
;

%%

void yyerror(char *s) {
  fprintf(stderr,"%s\n",s);
}

/* Phase2*/
/* mini_l.y */
/*Calvin Huynh, Jonathan Pang*/
/*Declarations*/
%{
#include "include.h"
int yyerror(int* t1, int* t2, int* t3);
int yylex(void);
%}
/*bison declarations*/
%union{
int int_val;
string* op_val;
}
%start input
%token PROGRAM BEGIN_PROGRAM END_PROGRAM INTEGER ARRAY OF IF THEN ENDIF ELSE ELSEIF WHILE DO BEGINLOOP ENDLOOP BREAK CONTINUE EXIT READ WRITE AND OR NOT TRUE FALSE L_BRACKET R_BRACKET L_PAREN R_PAREN IDENT NUMBER SEMICOLON COLON COMMA QUESTION ASSIGN COMMENT EQ NEQ LT GT LTE GTE 
%left ADD
%left SUB
%left MOD
%left DIV
%left MULT

%%
/*grammar rules*/
input: /* empty */
	| Term { }
	;
/*
exp: INTEGER_LITERAL { $$ = $1; }
	| exp PLUS exp { $$ = $1 + $3; }
	| exp MULT exp { $$ = $1 * $3; }
	;*/

/*NON-TERMINALS*/
 

Term: Term1 Term2 {printf("term -> term1 term2\n");}
	| Term2 {printf("term -> term2\n");}
	;

Term1: SUB {printf("term1 -> sub\n");}
	;

Term2: Var {printf("term2 -> var\n");}
	| NUMBER {printf("term2 -> number\n");}
	| L_PAREN Exp R_PAREN {printf("l_paren exp r_paren\n");}
	;
/*{printf("\n");}*/
Var: IDENT {printf("var -> ident\n");}
	| IDENT L_BRACKET Exp R_BRACKET {printf("var -> ident l_bracket exp r_bracket\n");}
	;

Exp: Mul_Exp {printf("exp -> exp\n");}
	| Exp ADD Exp {printf("exp -> exp add exp\n");}
	| Exp SUB Exp {printf("exp -> exp sub exp\n");}
	;

Mul_Exp: Mul_Exp MULT Mul_Exp {printf("exp -> exp mult exp\n");}
	| Mul_Exp DIV Mul_Exp {printf("exp -> exp div exp\n");}
	| Mul_Exp MOD Mul_Exp {printf("exp -> exp mod exp\n");}
	| Term {printf("exp -> term\n");}
	;

/*TERMINALS*/
/*
L_BRACKET: {printf("l_bracket -> L_BRACKET\n");};
R_BRACKET: {printf("r_bracket -> R_BRACKET\n");};
L_PAREN: {printf("l_paren -> L_PAREN\n");};
R_PAREN: {printf("r_paren -> R_PAREN\n");};*/
/*
NUMBER: {printf("number -> NUMBER (%d)\n" ,yytext);};

IDENT: {printf("ident -> IDENT (%s)\n" , yytext);};*/
%%
/*additional c code*/
int yyerror(int line, int column, int err)
{
	extern char *yytext;
	if(err == 1){ 
		printf("Error at line %d, column %d: identifier \"%s\" must begin with letter. Exiting program.\n", line, column, yytext); exit(0);
	}
else if (err == 2){
printf("Error at line %d, column %d: identifier \"%s\" must not end with underscore. Exiting program.\n", line, column, yytext); exit(0);
}
else if (err == 3) printf("Error at line %d, column %d: unrecognized symbol \"%s\". Exiting program.\n", line, column, yytext); exit(0);
}

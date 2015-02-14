/* Phase2*/
/* mini_l.y */
/*Calvin Huynh, Jonathan Pang*/

/*Declarations*/
%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

/*bison declarations*/
%union{
  int		int_val;
  string*	op_val;
}

%start	input 

%token	<int_val>	INTEGER_LITERAL
%type	<int_val>	exp
%left	PLUS
%left	MULT

%%

/*grammar rules*/

input:		/* empty */
		| exp	{ cout << "Result: " << $1 << endl; }
		;

exp:		INTEGER_LITERAL	{ $$ = $1; }
		| exp PLUS exp	{ $$ = $1 + $3; }
		| exp MULT exp	{ $$ = $1 * $3; }
		;
    
Term: Term1 Term2 
      | Term2
      ;
      
Term1: SUB;

SUB: {printf("Term1 -> SUB\n")};

Term2: Var 
       | NUMBER {} 
       | L_PAREN Expression R_PAREN {}
       ;
       
NUMBER: {printf("NUMBER -> (%d)" ,yytext)};
%%

/*additional c code*/

int yyerror(int l, int c, int err)
{
  extern char *yytext;	// defined and maintained in lex.c
  if(err == 1) printf("Error at line %d, column %d: identifier \"%s\" must begin with letter. Exiting program.\n", line, column, yytext); exit(0);
  else if (err == 2) printf("Error at line %d, column %d: identifier \"%s\" must not end with underscore. Exiting program.\n", line, column, yytext); exit(0);
  else if (err == 3) printf("Error at line %d, column %d: unrecognized symbol \"%s\". Exiting program.\n", line, column, yytext); exit(0);
  
  
}

int yyerror(char *s)
{
  return yyerror(string(s));
}



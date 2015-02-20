/* Phase2*/
/* mini_l.y */
/*Calvin Huynh, Jonathan Pang*/

/*Declarations*/
%{
#include "heading.h"
int yyerror(char* s);
int yylex(void);
extern char *yytext;
%}

/*bison declarations*/
/*
%union{
  int           int_val;
  string      op_val; 
}
*/

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
  | Bool_Exp
	;
/*
exp: INTEGER_LITERAL { $$ = $1; }
	| exp PLUS exp { $$ = $1 + $3; }
	| exp MULT exp { $$ = $1 * $3; }
	;*/

/*NON-TERMINALS*/
Program: PROGRAM IDENT SEMICOLON Block ENDPROGRAM
  ; 
  
Block: Block1 BEGINPROGRAM Block2 {printf("block -> block1 beginprogram block2\n");}
  ;

Block1: /*EMPTY*/ {printf("block1 -> \n");}
  | Declaration SEMICOLON Block1 {printf("block1 -> declaration semicolon block1\n");}
  ;

Block2: /*EMPTY*/ {printf("block2 -> \n");}
  | Statement SEMICOLON Block2 {printf("block2 -> statement semicolon block2\n");}
  ;
  
Declaration: IDENT Declaration1 COLON Declaration 2 {printf("declaration -> ident declaration1 colon declaration2\n");}
  ;

Declaration1: /*EMPTY*/ {printf("declaration1 -> \n");}
  | COMMA IDENT Declaration1 {printf("declaration1 -> comma ident declaration1\n");}
  ;
  
Declaration2: INTEGER {printf("declaration2 -> integer\n");}
  | ARRAY L_BRACKET NUMBER R_BRACKET OF INTEGER{printf("declaration2 -> array l_bracket number r_bracket of integer\n");}
  ;
Bool_Exp: Bool_Exp OR Bool_Exp {printf("bool_exp -> bool_exp or bool_exp\n");}
  | Rel_And_Exp {printf("bool_exp -> relation_and_exp\n");}
  ;
  
Rel_And_Exp: Rel_And_Exp AND Rel_And_Exp {printf("relation_and_exp -> relation_and_exp and relation_and_exp\n");}
  |Rel_Exp {printf("relation_and_exp -> relation_exp\n");}
  ;
  
Rel_Exp: Rel_Exp1 Rel_Exp2 {printf("relation_exp -> relation_exp1 relation_exp2\n");}
	| Rel_Exp2 {printf("relation_exp -> relation_exp2\n");}
	;

Rel_Exp1: NOT {printf("relation_exp1 -> not\n");}
  ;

Rel_Exp2: Exp Comp Exp {printf("relation_exp2 -> expression comp expression\n");}
  | TRUE {printf("relation_exp2 -> true\n");}
  | FALSE {printf("relation_exp2 -> false\n");}
  | L_PAREN Bool_Exp R_PAREN {printf("relation_exp2 -> l_paren expression r_paren\n");}
  ;
Comp: EQ 
  | NEQ 
  | LT 
  | GT 
  | LTE 
  | GTE  
  ;
Term: Term1 Term2 {printf("term -> term1 term2\n");}
	| Term2 {printf("term -> term2\n");}
	;

Term1: SUB {printf("term1 -> sub\n");}
	;

Term2: Var {printf("term2 -> var\n");}
	| NUMBER {printf("term2 -> number\n");}
	| L_PAREN Exp R_PAREN {printf("l_paren expression r_paren\n");}
	;
/*{printf("\n");}*/
Var: IDENT {printf("var -> ident\n");}
	| IDENT L_BRACKET Exp R_BRACKET {printf("var -> ident l_bracket expression r_bracket\n");}
	;

Exp: Mul_Exp {printf("expression -> expression\n");}
	| Exp ADD Exp {printf("expression -> expression add expression\n");}
	| Exp SUB Exp {printf("expression -> expression sub expression\n");}
	;

Mul_Exp: Mul_Exp MULT Mul_Exp {printf("expression -> expression mult expression\n");}
	| Mul_Exp DIV Mul_Exp {printf("expression -> expression div expression\n");}
	| Mul_Exp MOD Mul_Exp {printf("expression -> expression mod expression\n");}
	| Term {printf("expression -> term\n");}
	;

/*TERMINALS*/

%%
/*additional c code*/
int yyerror(string s)
{
	extern int line;
  extern int column;
  extern int err;
  /* extern char *yytext;*/
	if(err == 1){ 
		printf("Error at line %d, column %d: identifier \"%s\" must begin with letter. Exiting program.\n", line, column, yytext); exit(0);
	}
  else if (err == 2){
    printf("Error at line %d, column %d: identifier \"%s\" must not end with underscore. Exiting program.\n", line, column, yytext); exit(0);
  }
  else if (err == 3) printf("Error at line %d, column %d: unrecognized symbol \"%s\". Exiting program.\n", line, column, yytext); exit(0);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}

/* Phase2*/
/* mini_l.y */
/*Calvin Huynh, Jonathan Pang*/

/*Declarations*/
%{
#include "heading.h"
int yyerror(char* s);
int yylex(void);
extern int produc;
extern int line;
extern int column;
extern int err;
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
	| Program { }
	| Term
  	| Bool_Exp
	;
/*
exp: INTEGER_LITERAL { $$ = $1; }
	| exp PLUS exp { $$ = $1 + $3; }
	| exp MULT exp { $$ = $1 * $3; }
	;*/

/*NON-TERMINALS*/

Program: PROGRAM IDENT SEMICOLON Block END_PROGRAM {produc +=1; printf("%d: prog_start -> program ident semicolon block end_program\n", produc);}
  ; 
  
Block: Declaration SEMICOLON Block1 BEGIN_PROGRAM Statement SEMICOLON Statement3 {produc +=1; printf("%d: block -> declaration semicolon block1 beginprogram statement semicolon statement3\n", produc);}
  ;

Block1: /*EMPTY*/ {produc +=1; printf("%d: block1 -> \n", produc);}
  | Declaration SEMICOLON Block1 {produc +=1; printf("%d: block1 -> declaration semicolon block1\n", produc);}
  ;
  
Declaration: IDENT Declaration1 COLON Declaration2 {produc +=1; printf("%d: declaration -> ident declaration1 colon declaration2\n", produc);}
  ;

Declaration1: /*EMPTY*/ {produc +=1; printf("%d: declaration1 -> \n", produc);}
  | COMMA IDENT Declaration1 {produc +=1; printf("%d: declaration1 -> comma ident declaration1\n", produc);}
  ;
  
Declaration2: INTEGER {produc +=1; printf("%d: declaration2 -> integer\n", produc);}
  | ARRAY L_BRACKET NUMBER R_BRACKET OF INTEGER{produc +=1; printf("%d: declaration2 -> array l_bracket number r_bracket of integer\n", produc);}
  ;

Statement: Var ASSIGN Exp  {produc += 1; printf("%d: statement -> var assign expression\n", produc);}
  |Var ASSIGN Bool_Exp QUESTION Exp COLON Exp {produc += 1; printf("%d: statement -> var assign bool_exp question expression colon expression\n", produc);}
  |IF Bool_Exp THEN Statement SEMICOLON Statement3 Statement4 ENDIF {produc += 1; printf("%d: statement -> if bool_exp then statement semicolon statement3 statement4 endif\n", produc);}
  |WHILE Bool_Exp BEGINLOOP Statement SEMICOLON Statement3 ENDLOOP {produc += 1; printf("%d: statement -> while bool_exp beginloop statement semicolon statement3 endloop\n", produc);}
  |DO BEGINLOOP Statement SEMICOLON Statement3 ENDLOOP WHILE Bool_Exp {produc += 1; printf("%d: statement -> do beginloop statement semicolon statement3 endloop while bool_exp\n", produc);}
  |READ Var Statement2 {produc +=1; printf("%d: statement -> read var statement2\n", produc);}
  |WRITE Var Statement2 {produc +=1; printf("%d: statement -> write var statement2\n", produc);}
  |BREAK
  |CONTINUE
  |EXIT
  ;

Statement2: /*EMPTY*/ {produc +=1; printf("%d: statement2 -> \n", produc);}
  | COMMA Var Statement2 {produc +=1; printf("%d: statement2 -> comma var statement2\n", produc);}
  ;

Statement3: /*EMPTY*/ {produc +=1; printf("%d: statement3 -> \n", produc);}
  | Statement SEMICOLON Statement3 {produc +=1; printf("%d: statement3 -> statement semicolon statement3\n", produc);}
  ;

Statement4: /*EMPTY*/ {produc +=1; printf("%d: statement4 -> \n", produc);}
  | ELSEIF Bool_Exp Statement SEMICOLON Statement3 Statement4 {produc += 1; printf("%d: statement4 -> elseif bool_exp statement semicolon statement3 statement4");}
  | ELSE Statement SEMICOLON Statement3 {produc += 1; printf("%d: statement4 -> else statement semicolon statement3\n", produc);}
  ;

Bool_Exp: Bool_Exp OR Bool_Exp {produc +=1; printf("%d: bool_exp -> bool_exp or bool_exp\n", produc);}
  | Rel_And_Exp {produc +=1; printf("%d: bool_exp -> relation_and_exp\n", produc);}
  ;
  
Rel_And_Exp: Rel_And_Exp AND Rel_And_Exp {produc +=1; printf("%d: relation_and_exp -> relation_and_exp and relation_and_exp\n", produc);}
  |Rel_Exp {produc +=1; printf("%d: relation_and_exp -> relation_exp\n", produc);}
  ;
  
Rel_Exp: Rel_Exp1 Rel_Exp2 {produc +=1; printf("%d: relation_exp -> relation_exp1 relation_exp2\n", produc);}
	| Rel_Exp2 {produc +=1; printf("%d: relation_exp -> relation_exp2\n", produc);}
	;

Rel_Exp1: NOT {produc +=1; printf("%d: relation_exp1 -> not\n", produc);}
  ;

Rel_Exp2: Exp Comp Exp {produc +=1; printf("%d: relation_exp2 -> expression comp expression\n", produc);}
  | TRUE {produc +=1; printf("%d: relation_exp2 -> true\n", produc);}
  | FALSE {produc +=1; printf("%d: relation_exp2 -> false\n", produc);}
  | L_PAREN Bool_Exp R_PAREN {produc +=1; printf("%d: relation_exp2 -> l_paren expression r_paren\n", produc);}
  ;
Comp: EQ 
  | NEQ 
  | LT 
  | GT 
  | LTE 
  | GTE  
  ;
Term: Term1 Term2 {produc +=1; printf("%d: term -> term1 term2\n", produc);}
	| Term2 {produc +=1; printf("%d: term -> term2\n", produc);}
	;

Term1: SUB {produc +=1; printf("%d: term1 -> sub\n", produc);}
	;

Term2: NUMBER {produc +=1; printf("%d: term2 -> number\n", produc);}
	| Var {produc +=1; printf("%d: term2 -> var\n", produc);}
	| L_PAREN Exp R_PAREN {produc +=1; printf("%d: l_paren expression r_paren\n", produc);}
	;
/*{printf("\n");}*/
Var: IDENT {produc +=1; printf("%d: var -> ident\n", produc);}
	| IDENT L_BRACKET Exp R_BRACKET {produc +=1; printf("%d: var -> ident l_bracket expression r_bracket\n", produc);}
	;

Exp: Mul_Exp {produc +=1; printf("%d: expression -> expression\n", produc);}
	| Exp ADD Exp {produc +=1; printf("%d: expression -> expression add expression\n", produc);}
	| Exp SUB Exp {produc +=1; printf("%d: expression -> expression sub expression\n", produc);}
	;

Mul_Exp: Mul_Exp MULT Mul_Exp {produc +=1; printf("%d: expression -> expression mult expression\n", produc);}
	| Mul_Exp DIV Mul_Exp {produc +=1; printf("%d: expression -> expression div expression\n", produc);}
	| Mul_Exp MOD Mul_Exp {produc +=1; printf("%d: expression -> expression mod expression\n", produc);}
	| Term {produc +=1; printf("%d: expression -> term\n", produc);}
	;

/*TERMINALS*/

%%
/*additional c code*/
int yyerror(string s)
{
  const char *tmp;
  tmp = s.c_str();
  /* extern char *yytext;*/
  if(err == 1){ 
    printf("Error at line %d, column %d: identifier \"%s\" must begin with letter. Exiting program.\n", line, column, yytext); exit(0);
  }
  else if (err == 2){
    printf("Error at line %d, column %d: identifier \"%s\" must not end with underscore. Exiting program.\n", line, column, yytext); exit(0);
  }
  else if (err == 3) { 
    printf("Error at line %d, column %d: unrecognized symbol \"%s\". Exiting program.\n", line, column, yytext); exit(0);
  }
  else{printf("Line%d: Parse error: %s\n", line, tmp); exit(0);}
}

int yyerror(char *s)
{
  printf("Line%d: Parse error: %s\n", line,s); exit(0);
  return yyerror(string(s));
}

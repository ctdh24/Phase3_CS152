/* 
 * CS 152 - Project Phase 1
 * Jonathan Pang
 * Calvin Huynh
 */
%{
#include "y.tab.h"
#include "heading.h"
int yyerror(char* s);
int yylex(void);
%}
/* Keep track of current line and column for error messages */
	int line = 1, column = 1, err = -1;

/* Task 1: Read text from standard-in and prints identified tokens, 1 token per line */

/* Reserved Words*/
PROGRAM ("program")
BEGIN_PROGRAM ("beginprogram")
END_PROGRAM ("endprogram")
INTEGER ("integer")
ARRAY ("array")
OF ("of")
IF ("if")
THEN ("then")
ENDIF ("endif")
ELSE ("else")
ELSEIF ("elseif")
WHILE ("while")
DO ("do")
BEGINLOOP ("beginloop")
ENDLOOP ("endloop")
BREAK ("break")
CONTINUE ("continue")
EXIT ("exit")
READ ("read")
WRITE ("write")
AND ("and")
OR ("or")
NOT ("not")
TRUE ("true")
FALSE ("false")

/* Arithemetic Operators*/
SUB ("-")
ADD ("+")
MULT ("*")
DIV ("/")
MOD ("%")

/* Comparison Operators*/
EQ ("==")
NEQ ("!=")
LT ("<")
GT (">")
LTE ("<=")
GTE (">=")

/* Identifiers and Numbers*/
digit [0-9]
IDENT  [a-z][a-z0-9_]*[a-z0-9]|[a-z]
FAKE_IDENT1 [0-9][a-z][a-z0-9_]*|[_][a-z][a-z0-9_]*
FAKE_IDENT2 [a-z][a-z0-9_]*_
NUMBER ({digit}+)




/* Other Special Symbols*/
SEMICOLON (";")
COLON (":")
COMMA (",")
QUESTION ("?")
L_BRACKET ("[")
R_BRACKET ("]")
L_PAREN ("(")
R_PAREN (")")
ASSIGN (":=")

/* Comment */
COMMENT ("##")(.)*

/* Actions that occur when reading in token */
%%
{PROGRAM} column+=yyleng; {printf("program -> PROGRAM\n");}
{BEGIN_PROGRAM} column+=yyleng; {printf("begin_program -> BEGIN_PROGRAM\n");}
{END_PROGRAM} column+=yyleng; {printf("end_program -> END_PROGRAM\n");}
{INTEGER} column+=yyleng; {printf("integer -> INTEGER \n");}
{ARRAY} column+=yyleng; {printf("array -> ARRAY\n");}
{OF} column+=yyleng; {printf("of -> OF\n");}
{IF} column+=yyleng; {printf("if -> IF\n");}
{THEN} column+=yyleng; {printf("then-> THEN\n");}
{ENDIF} column+=yyleng; {printf("endif -> ENDIF\n");}
{ELSE} column+=yyleng; {printf("else -> ELSE\n");}
{ELSEIF} column+=yyleng; {printf("elseif -> ELSEIF\n");}
{WHILE} column+=yyleng; {printf("while -> WHILE\n");}
{DO} column+=yyleng; {printf("do -> DO\n");}
{BEGINLOOP} column+=yyleng; {printf("beginloop -> BEGINLOOP\n");}
{ENDLOOP} column+=yyleng; {printf("endloop -> ENDLOOP\n");}
{BREAK} column+=yyleng; {printf("break -> BREAK\n");}
{CONTINUE} column+=yyleng; {printf("continue -> CONTINUE\n");}
{EXIT} column+=yyleng;{printf("exit -> EXIT\n");}
{READ} column+=yyleng; {printf("read -> READ\n");}
{WRITE} column+=yyleng; {printf("write -> WRITE\n");}
{AND} column+=yyleng; {printf("and -> AND\n");}
{OR} column+=yyleng; {printf("or -> OR\n");}
{NOT} column+=yyleng; {printf("not -> NOT\n");}
{TRUE} column+=yyleng; {printf("true -> TRUE\n");}
{FALSE} column+=yyleng; {printf("false -> FALSE\n");}
{SUB} column+=yyleng; 
{ADD} column+=yyleng; 
{MULT} column+=yyleng; 
{DIV} column+=yyleng; 
{MOD} column+=yyleng; 
{EQ} column+=yyleng; {printf("comp -> EQ\n");}
{NEQ} column+=yyleng; {printf("comp -> NEQ\n");}
{LT} column+=yyleng; {printf("comp -> LT\n");}
{GT} column+=yyleng; {printf("comp -> GT\n");}
{LTE} column+=yyleng; {printf("comp -> LTE\n");}
{GTE} column+=yyleng; {printf("comp -> GTE\n");}
{NUMBER} column+=yyleng; {printf("number -> NUMBER (%s)\n" ,yytext);}
{SEMICOLON} column+=yyleng; {printf("semicolon -> SEMICOLON\n");}
{COLON} column+=yyleng;{printf("colon -> COLON\n");}
{COMMA} column+=yyleng; {printf("comma -> COMMA\n");}
{QUESTION} column+=yyleng; {printf("question -> QUESTION\n");}
{L_BRACKET} column+=yyleng; {printf("l_bracket -> L_BRACKET\n");}
{R_BRACKET} column+=yyleng; {printf("r_bracket -> R_BRACKET\n"); }
{L_PAREN} column+=yyleng; {printf("l_paren -> L_PAREN\n"); }
{R_PAREN} column+=yyleng; {printf("r_paren -> R_PAREN\n"); }
{ASSIGN} column+=yyleng; {printf("assign -> ASSIGN\n");}
{IDENT} column+=yyleng; {printf("ident -> IDENT (%s)\n" , yytext);}
{COMMENT} column+=yyleng;
[ \t\r] column++; /*ignore whitespace. the space at the front is necessary for single space */
[\n] ++line; column = 1;

{FAKE_IDENT1} {err = 1; yyerror(""); exit(0);}
{FAKE_IDENT2} {err = 2; yyerror(""); exit(0);}
. err = 3; yyerror(""); exit(0);
%%
/*
int main( int argc, char **argv )
{
	 ++argv, --argc;  
	 if ( argc > 0 )
		 yyin = fopen( argv[0], "r" );
	 else
		 yyin = stdin;
 
	 yylex();
	 
}
*/

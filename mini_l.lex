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
	int line = 1, column = 1, err = -1, produc = 0;

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
{PROGRAM} column+=yyleng; produc +=1; {printf("%d: program -> PROGRAM\n", produc); return PROGRAM;}
{BEGIN_PROGRAM} column+=yyleng; produc +=1; {printf("%d: begin_program -> BEGIN_PROGRAM\n", produc); return BEGIN_PROGRAM;}
{END_PROGRAM} column+=yyleng; produc +=1; {printf("%d: end_program -> END_PROGRAM\n", produc); return END_PROGRAM;}
{INTEGER} column+=yyleng; produc +=1; {printf("%d: integer -> INTEGER \n", produc); return INTEGER;}
{ARRAY} column+=yyleng; produc +=1; {printf("%d: array -> ARRAY\n", produc); return ARRAY;}
{OF} column+=yyleng; produc +=1; {printf("%d: of -> OF\n", produc); return OF;}
{IF} column+=yyleng; produc +=1; {printf("%d: if -> IF\n", produc); return IF;}
{THEN} column+=yyleng; produc +=1; {printf("%d: then-> THEN\n", produc); return THEN;}
{ENDIF} column+=yyleng; produc +=1; {printf("%d: endif -> ENDIF\n", produc); return ENDIF;}
{ELSE} column+=yyleng; produc +=1; {printf("%d: else -> ELSE\n", produc); return ELSE;}
{ELSEIF} column+=yyleng; produc +=1; {printf("%d: elseif -> ELSEIF\n", produc); return ELSEIF;}
{WHILE} column+=yyleng; produc +=1; {printf("%d: while -> WHILE\n", produc); return WHILE;}
{DO} column+=yyleng; produc +=1; {printf("%d: do -> DO\n", produc); return DO;}
{BEGINLOOP} column+=yyleng; produc +=1; {printf("%d: beginloop -> BEGINLOOP\n", produc); return BEGINLOOP;}
{ENDLOOP} column+=yyleng; produc +=1; {printf("%d: endloop -> ENDLOOP\n", produc); return ENDLOOP;}
{BREAK} column+=yyleng; produc +=1; {printf("%d: break -> BREAK\n", produc); return BREAK;}
{CONTINUE} column+=yyleng; produc +=1; {printf("%d: continue -> CONTINUE\n", produc); return CONTINUE;}
{EXIT} column+=yyleng;produc +=1; {printf("%d: exit -> EXIT\n", produc); return EXIT;}
{READ} column+=yyleng; produc +=1; {printf("%d: read -> READ\n", produc); return READ;}
{WRITE} column+=yyleng; produc +=1; {printf("%d: write -> WRITE\n", produc); return WRITE;}
{AND} column+=yyleng; produc +=1; {printf("%d: and -> AND\n", produc); return AND;}
{OR} column+=yyleng; produc +=1; {printf("%d: or -> OR\n", produc); return OR;}
{NOT} column+=yyleng; produc +=1; {printf("%d: not -> NOT\n", produc); return NOT;}
{TRUE} column+=yyleng; produc +=1; {printf("%d: true -> TRUE\n", produc); return TRUE;}
{FALSE} column+=yyleng; produc +=1; {printf("%d: false -> FALSE\n", produc); return FALSE;}
{SUB} column+=yyleng; {return SUB;}
{ADD} column+=yyleng; {return ADD;}
{MULT} column+=yyleng; {return MULT;}
{DIV} column+=yyleng; {return DIV;}
{MOD} column+=yyleng; {return MOD;}
{EQ} column+=yyleng; produc +=1; {printf("%d: comp -> EQ\n", produc); return EQ;}
{NEQ} column+=yyleng; produc +=1; {printf("%d: comp -> NEQ\n", produc); return NEQ;}
{LT} column+=yyleng; produc +=1; {printf("%d: comp -> LT\n", produc); return LT;}
{GT} column+=yyleng; produc +=1; {printf("%d: comp -> GT\n", produc); return GT;}
{LTE} column+=yyleng; produc +=1; {printf("%d: comp -> LTE\n", produc); return LTE;}
{GTE} column+=yyleng; produc +=1; {printf("%d: comp -> GTE\n", produc); return GTE;}
{NUMBER} column+=yyleng; produc +=1; {printf("%d: number -> NUMBER (%s)\n", produc, yytext); return NUMBER;}
{SEMICOLON} column+=yyleng; produc +=1; {printf("%d: semicolon -> SEMICOLON\n", produc); return SEMICOLON;}
{COLON} column+=yyleng;produc +=1; {printf("%d: colon -> COLON\n", produc); return COLON;}
{COMMA} column+=yyleng; produc +=1; {printf("%d: comma -> COMMA\n", produc); return COMMA;}
{QUESTION} column+=yyleng; produc +=1; {printf("%d: question -> QUESTION\n", produc); return QUESTION;}
{L_BRACKET} column+=yyleng; produc +=1; {printf("%d: l_bracket -> L_BRACKET\n", produc); return L_BRACKET;}
{R_BRACKET} column+=yyleng; produc +=1; {printf("%d: r_bracket -> R_BRACKET\n", produc); return R_BRACKET;}
{L_PAREN} column+=yyleng; produc +=1; {printf("%d: l_paren -> L_PAREN\n", produc); return L_PAREN;}
{R_PAREN} column+=yyleng; produc +=1; {printf("%d: r_paren -> R_PAREN\n", produc); return R_PAREN;}
{ASSIGN} column+=yyleng; produc +=1; {printf("%d: assign -> ASSIGN\n", produc); return ASSIGN;}

{IDENT} column+=yyleng; produc +=1; {printf("%d: ident -> IDENT (%s)\n", produc, yytext); return IDENT;}
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

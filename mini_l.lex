/* 
 * CS 152 - Project Phase 1
 * Jonathan Pang
 * Calvin Huynh
 */

/* Keep track of current line and column for error messages */
	int line = 1, column = 1;

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
EQ ("=")
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
{PROGRAM} column+=yyleng; return PROGRAM;
{BEGIN_PROGRAM} column+=yyleng; return BEGIN_PROGRAM; 
{END_PROGRAM} column+=yyleng; return END_PROGRAM; 
{INTEGER} column+=yyleng; return INTEGER;
{ARRAY} column+=yyleng; return ARRAY;
{OF} column+=yyleng; return OF;
{IF} column+=yyleng; return IF;
{THEN} column+=yyleng; return THEN;
{ENDIF} column+=yyleng; return ENDIF;
{ELSE} column+=yyleng; return ELSE;
{ELSEIF} column+=yyleng; return ELSEIF;
{WHILE} column+=yyleng; return WHILE;
{DO} column+=yyleng; return DO;
{BEGINLOOP} column+=yyleng; return BEGINLOOP;
{ENDLOOP} column+=yyleng; return ENDLOOP;
{BREAK} column+=yyleng; return BREAK;
{CONTINUE} column+=yyleng; return CONTINUE;
{EXIT} column+=yyleng; return EXIT;
{READ} column+=yyleng; return READ;
{WRITE} column+=yyleng; return WRITE;
{AND} column+=yyleng; return AND; 
{OR} column+=yyleng; return OR;
{NOT} column+=yyleng; return NOT;
{TRUE} column+=yyleng; return TRUE;
{FALSE} column+=yyleng; return FALSE;
{SUB} column+=yyleng; return SUB;
{ADD} column+=yyleng; return ADD;
{MULT} column+=yyleng; return MULT;
{DIV} column+=yyleng; return DIV;
{MOD} column+=yyleng; return MOD;
{EQ} column+=yyleng; return EQ;
{NEQ} column+=yyleng; return NEQ;
{LT} column+=yyleng; return LT;
{GT} column+=yyleng; return GT;
{LTE} column+=yyleng; return LTE;
{GTE} column+=yyleng; return GTE;
{NUMBER} column+=yyleng; return NUMBER;
{SEMICOLON} column+=yyleng; return SEMICOLON;
{COLON} column+=yyleng; return COLON;
{COMMA} column+=yyleng; return COMMA;
{QUESTION} column+=yyleng; return QUESTION;
{L_BRACKET} column+=yyleng; return L_BRACKET;
{R_BRACKET} column+=yyleng; return R_BRACKET;
{L_PAREN} column+=yyleng; return L_PAREN;
{R_PAREN} column+=yyleng; return R_PAREN;
{ASSIGN} column+=yyleng; return ASSIGN; 
{IDENT} column+=yyleng; return IDENT;
{COMMENT} column+=yyleng;
[ \t\r] column++; /*ignore whitespace. the space at the front is necessary for single space */
[\n] ++line; column = 1;

{FAKE_IDENT1} yyerror(line, column, 1); exit(0);
{FAKE_IDENT2} yyerror(line, column, 2); exit(0);
. yyerror(line, column, 3); exit(0);
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

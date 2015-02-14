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
IDENT [a-z][a-z0-9_]*[a-z0-9]|[a-z]
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
{PROGRAM} column+=yyleng; printf("PROGRAM \n");
{BEGIN_PROGRAM} column+=yyleng; printf("BEGIN_PROGRAM \n");
{END_PROGRAM} column+=yyleng; printf("END_PROGRAM \n");
{INTEGER} column+=yyleng; printf("INTEGER \n");
{ARRAY} column+=yyleng; printf("ARRAY \n");
{OF} column+=yyleng; printf("OF \n");
{IF} column+=yyleng; printf("IF \n");
{THEN} column+=yyleng; printf("THEN \n");
{ENDIF} column+=yyleng; printf("ENDIF \n");
{ELSE} column+=yyleng; printf("ELSE \n");
{ELSEIF} column+=yyleng; printf("ELSEIF \n");
{WHILE} column+=yyleng; printf("WHILE \n");
{DO} column+=yyleng; printf("DO \n");
{BEGINLOOP} column+=yyleng; printf("BEGINLOOP \n");
{ENDLOOP} column+=yyleng; printf("ENDLOOP \n");
{BREAK} column+=yyleng; printf("BREAK \n");
{CONTINUE} column+=yyleng; printf("CONTINUE \n");
{EXIT} column+=yyleng; printf("EXIT \n");
{READ} column+=yyleng; printf("READ \n");
{WRITE} column+=yyleng; printf("WRITE \n");
{AND} column+=yyleng; printf("AND \n");
{OR} column+=yyleng; printf("OR \n");
{NOT} column+=yyleng; printf("NOT \n");
{TRUE} column+=yyleng; printf("TRUE \n");
{FALSE} column+=yyleng; printf("FALSE \n");
{SUB} column+=yyleng; printf("SUB \n");
{ADD} column+=yyleng; printf("ADD \n");
{MULT} column+=yyleng; printf("MULT \n");
{DIV} column+=yyleng; printf("DIV \n");
{MOD} column+=yyleng; printf("MOD \n");
{EQ} column+=yyleng; printf("EQ \n");
{NEQ} column+=yyleng; printf("NEQ \n");
{LT} column+=yyleng; printf("LT \n");
{GT} column+=yyleng; printf("GT \n");
{LTE} column+=yyleng; printf("LTE \n");
{GTE} column+=yyleng; printf("GTE \n");
{NUMBER} column+=yyleng; printf("NUMBER %s\n",yytext);
{SEMICOLON} column+=yyleng; printf("SEMICOLON \n");
{COLON} column+=yyleng; printf("COLON \n");
{COMMA} column+=yyleng; printf("COMMA \n");
{QUESTION} column+=yyleng; printf("QUESTION \n");
{L_BRACKET} column+=yyleng; printf("L_BRACKET \n");
{R_BRACKET} column+=yyleng; printf("R_BRACKET \n");
{L_PAREN} column+=yyleng; printf("L_PAREN \n");
{R_PAREN} column+=yyleng; printf("R_PAREN \n");
{ASSIGN} column+=yyleng; printf("ASSIGN \n");
{IDENT} column+=yyleng; printf("IDENT %s\n", yytext);
{COMMENT} column+=yyleng; printf("");
[ \t\r] column++; /*ignore whitespace. the space at the front is necessary for single space */
[\n] ++line; column = 1;
{FAKE_IDENT1} printf("Error at line %d, column %d: identifier \"%s\" must begin with letter. Exiting program.\n", line, column, yytext); exit(0);
{FAKE_IDENT2} printf("Error at line %d, column %d: identifier \"%s\" must not end with underscore. Exiting program.\n", line, column, yytext); exit(0);
. printf("Error at line %d, column %d: unrecognized symbol \"%s\". Exiting program.\n", line, column, yytext); exit(0);
%%
int main( int argc, char **argv )
{
++argv, --argc; /* skip over program name */
if ( argc > 0 )
yyin = fopen( argv[0], "r" );
else
yyin = stdin;
yylex();
}

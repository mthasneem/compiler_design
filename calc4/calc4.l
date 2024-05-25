%{
#include <stdlib.h>
#include "calc4.h"
#include "y.tab.h"

void yyerror(char *);  /* Error handling function */
%}

%%

/* Match single lowercase letters as variables */
[a-z] {
    yylval.sIndex = *yytext - 'a';
    return VARIABLE;
}

/* Match single digit 0 */
0 {
    yylval.iValue = atoi(yytext);
    return INTEGER;
}

/* Match integers starting with non-zero digits */
[1-9][0-9]* {
    yylval.iValue = atoi(yytext);
    return INTEGER;
}

/* Match single character operators and punctuation */
[-()<>=+*/;{}.] {
    return *yytext;
}

/* Match multi-character operators */
">=" { return GE; }
"<=" { return LE; }
"==" { return EQ; }
"!=" { return NE; }

/* Match keywords */
"while" { return WHILE; }
"if" { return IF; }
"else" { return ELSE; }
"then" { return THEN; }
"print" { return PRINT; }

/* Ignore whitespace characters */
[ \t\n]+ ;

/* Handle unknown characters */
. { yyerror("Unknown character"); }

%%

/* Function called at the end of input */
int yywrap(void) {
    return 1;
}


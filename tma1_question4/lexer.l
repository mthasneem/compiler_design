%{
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"

void yyerror(char *);  /* Error handling function */
%}

%%

/* Match single lowercase letters as variables */
[a-zA-Z][a-zA-Z0-9_]* {
    yylval.sIndex = *yytext - 'a';
    return IDENTIFIER;
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

/* Match floating point numbers */
[0-9]+\.[0-9]*([eE][+-]?[0-9]+)? {
    yylval.fValue = atof(yytext);
    return FLOAT;
}

/* Match multi-character operators */
"<>" { return NE; }
">=" { return GE; }
"<=" { return LE; }
"==" { return EQ; }
"or" { return OR; }
"and" { return AND; }
"not" { return NOT; }

/* Match single character operators and punctuation */
"(" { return '('; }
")" { return ')'; }
"{" { return '{'; }
"}" { return '}'; }
"[" { return '['; }
"]" { return ']'; }
";" { return ';'; }
"," { return ','; }
"." { return '.'; }
":" { return ':'; }
"->" { return ARROW; }
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
"=" { return '='; }

/* Match keywords */
"else" { return ELSE; }
"float" { return FLOAT_KW; }
"func" { return FUNC; }
"if" { return IF; }
"impl" { return IMPL; }
"inherits" { return INHERITS; }
"integer" { return INTEGER_KW; }
"self" { return SELF; }
"let" { return LET; }
"struct" { return STRUCT; }
"private" { return PRIVATE; }
"then" { return THEN; }
"public" { return PUBLIC; }
"var" { return VAR; }
"read" { return READ; }
"void" { return VOID; }
"while" { return WHILE; }
"return" { return RETURN; }
"write" { return WRITE; }

/* Ignore whitespace characters */
[ \t\n]+ ;

/* Handle comments */
"//"(.*) { /* Match inline comments */ }
"/*"([^*]|\*+[^*/])*"*+/" { /* Match block comments */ }

/* Handle unknown characters */
. { yyerror("Unknown character"); }

%%

/* Function called at the end of input */
int yywrap(void) {
    return 1;
}


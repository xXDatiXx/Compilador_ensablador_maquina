%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define aquí cualquier función adicional necesaria o incluye encabezados.
void yyerror(const char *s);
int yylex(void);

%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUMBER
%token <sval> LABEL
%token MOV INT RET JMP JZ JE INC CMP
%token AX BX CX DX REG

%type <ival> expression
%type <sval> identifier

%%
program:
    statements
;

statements:
    statement '\n' statements
    |
    statement
;

statement:
    MOV expression ',' expression       { printf("MOV instruction\n"); }
  | INT expression                      { printf("INT instruction\n"); }
  | JMP expression                      { printf("JMP instruction\n"); }
  | JZ expression                       { printf("JZ instruction\n"); }
  | JE expression                       { printf("JE instruction\n"); }
  | CMP expression ',' expression       { printf("CMP instruction\n"); }
  | RET                                 { printf("RET instruction\n"); }
;

expression:
    NUMBER                              { $$ = $1; }
  | REG                                 { $$ = 0; } // You might want to handle registers differently
  | identifier                          { $$ = 0; } // Placeholders for identifiers
;

identifier:
    LABEL                               { $$ = strdup($1); }
;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    printf("Starting the parser...\n");
    if (yyparse() == 0) {
        printf("Assembly parsed successfully.\n");
    } else {
        printf("Failed to parse assembly.\n");
    }
    return 0;
}

%token MOV INT RET JMP JZ JE INC CMP
%token REG DL DH AX BX CX DX
%token NUMBER LABEL

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern int yylex(); //Para acceder a las funciones de lex
    extern FILE *yyin; //Detectar un archivo externo, en este caso lo que va a reconcoer
    int yyerror(const char* s);
	#pragma warning(disable: )


%}

%union {
    int ival;   // Usado para valores enteros
    char *sval; // Usado para cadenas de caracteres
}

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
int yyerror(const char *s) {
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

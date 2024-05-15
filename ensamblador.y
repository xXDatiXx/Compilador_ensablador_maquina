%token MOV INToken RET JMP JZ JE INC CMP ORG
%token REG DL DH AX BX CX DX 

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "codegen.h"
    CodeGen codegen();

    extern int yylex(); //Para acceder a las funciones de lex
    extern FILE *yyin; //Detectar un archivo externo, en este caso lo que va a reconcoer
    int yyerror(const char* s);
	#pragma warning(disable: )

%}

%union {
    int ival;   // Usado para valores enteros
    char *sval; // Usado para cadenas de caracteres

}

%token <ival> NUMBER
%token <sval> HEX_NUMBER
%token <sval> LABEL
%type <ival> expression
%type <sval> identifier
%left ","

%%
program:
    | program statement
    ;

statement:
      instruction '\n'    { /* acción cuando se parsea una instrucción seguida por un salto de línea */ }
    | instruction          { /* acción para instrucción sin salto de línea al final */ }
    ;

instruction:
        ORG NUMBER { /* acción cuando se encuentra `org` seguido por un número */ }
    | MOV expression ',' expression { printf("MOV instruction\n"); }
    | INToken expression          { printf("INT instruction\n"); }
    | JMP expression              { printf("JMP instruction\n"); }
    | JZ expression               { printf("JZ instruction\n"); }
    | JE expression               { printf("JE instruction\n"); }
    | CMP expression ',' expression { printf("CMP instruction\n"); }
    | RET                         { printf("RET instruction\n"); }
    ;


expression:
    NUMBER                              { $$ = $1; }                  
  | REG                                 { $$ = 0; } // You might want to handle registers differently
  | identifier                          { $$ = 0; } // Placeholders for identifiers
;

identifier:
    LABEL                               { printf("LABEL \n"); }
;

%%
int yyerror(const char *s) {

   char mensaje[100];

   if ( !strcmp( s, "parse error" ) )
      strcpy( mensaje, "Error de sintaxis" );
   else
      strcpy( mensaje, s );

   //printf("Error en linea %d: %s\n", linea, mensaje);
   exit( 1 ); /* Sale del programa */

   return 0;
}

int main(int argc, char ** argv )
{
    ++argv, --argc;  
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yyparse();

    return 0;
}
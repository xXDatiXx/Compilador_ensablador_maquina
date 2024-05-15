%token ORG MOV INToken RET JMP JZ JE INC CMP COMA LABEL
%token DL DH AX BX CX DX BL

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

%type <ival> expression
%left ","

%%
program:
    | program statement
    ;

statement:
    instruction  
    ;

instruction:
    ORG HEX_NUMBER                   { printf("ORG instruction\n"); }
    | MOV expression COMA expression { printf("MOV instruction\n"); }
    | INToken expression             { printf("INT instruction\n"); }
    | INC expression                 { printf("INC instruction\n")}
    | JMP expression                 { printf("JMP instruction\n"); }
    | JZ expression                  { printf("JZ instruction\n"); }
    | JE expression                  { printf("JE instruction\n"); }
    | CMP expression COMA expression { printf("CMP instruction\n"); }
    | RET                            { printf("RET instruction\n"); }
    | LABEL                          { printf("LABEL \n"); }
    ;


expression:
    NUMBER                                              
  | DL
  | DH
  | AX
  | BX
  | CX
  | DX
  | BL
  | HEX_NUMBER
  | LABEL
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
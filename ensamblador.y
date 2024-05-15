%token ORG MOV INToken RET JMP JZ JE INC CMP COMA LABEL
%token DL DH AX BX CX DX BL

%{
    #include <stdio.h>
    #include <stdlib.h>

    extern int yylex(); //Para acceder a las funciones de lex
    extern FILE *yyin; //Detectar un archivo externo, en este caso lo que va a reconcoer
    int yyerror(const char* s);
	#pragma warning(disable: 4267 4244 4273 4065)

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
    ORG expression                   { printf("--ORG instruction: 0000 0001\n"); }
    | MOV expression COMA expression { printf("--MOV instruction: 0000 0010\n"); }
    | INToken expression             { printf("--INT instruction: 0000 0011\n"); }
    | INC expression                 { printf("--INC instruction: 0000 0100\n"); }
    | JMP expression                 { printf("--JMP instruction: 0000 0101\n"); }
    | JZ expression                  { printf("--JZ instruction: 0000 0110\n"); }
    | JE expression                  { printf("--JE instruction: 0000 0111\n"); }
    | CMP expression COMA expression { printf("--CMP instruction: 0000 1000\n"); }
    | RET                            { printf("--RET instruction: 0000 1001\n"); }
    | LABEL                          { printf("--LABEL instruction: 0000 1010 \n"); }
    ;


expression:
    NUMBER           { /* Se imprime en lex */ }                                   
  | DL               { printf("--DL expression: 0000 1100\n"); }      
  | DH               { printf("--DH expression: 0000 1101\n"); }      
  | AX               { printf("--AX expression: 0000 1110\n"); }      
  | BX               { printf("--BX expression: 0000 1111\n"); }      
  | CX               { printf("--CX expression: 0001 0000\n"); }      
  | DX               { printf("--DX expression: 0001 0001\n"); }      
  | BL               { printf("--BL expression: 0001 0010\n"); }      
  | HEX_NUMBER       { /* Se imprime en flex*/ }      
  | LABEL            { printf("--LABEL expression:0001 0100")}
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
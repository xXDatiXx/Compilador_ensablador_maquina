%token ORG MOV INToken RET JMP JZ JE INC CMP LABEL
%token DL DH AX BX CX BL AH BH

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
    ORG expression                  { printf("--ORG instruction: FF\n"); }
    | MOV AX                        { printf("--MOV AX instruction: FE\n"); }
    | MOV BX                        { printf("--MOV BX instruction: FD\n"); }
    | MOV DL                        { printf("--MOV DL instruction: FC\n"); }
    | MOV DH                        { printf("--MOV DH instruction: FB\n"); }
    | MOV AH                        { printf("--MOV AH instruction: FA\n"); }
    | MOV CX                        { printf("--MOV CX instruction: F9\n"); }
    | MOV BL                        { printf("--MOV BL instruction: F9\n"); }
    | MOV BH                        { printf("--MOV BH instruction: EA\n"); }
    | INToken expression            { printf("--INT instruction: F7\n"); }
    | INC expression                { printf("--INC instruction: F6\n"); }
    | INC BL                        { printf("--INC BL instruction: F5\n"); }
    | INC DH                        { printf("--INC DH instruction: F4\n"); }
    | INC DL                        { printf("--INC DL instruction: F3\n"); }
    | JMP expression                { printf("--JMP instruction: F2\n"); }
    | JZ expression                 { printf("--JZ instruction: F1\n"); }
    | JE expression                 { printf("--JE instruction: F0\n"); }
    | CMP DH                        { printf("--CMP DH instruction: EF\n"); }
    | CMP DL                        { printf("--CMP DL instruction: EE\n"); }
    | RET                           { printf("--RET instruction: ED\n"); }
    | LABEL                         { printf("--LABEL instruction: EC \n"); }
    | NUMBER                        { /* Se imprime en flex */ }
    | HEX_NUMBER                    { /* Se imprime en flex*/ }      

    ;


expression:  
  HEX_NUMBER       { /* Se imprime en flex*/ }      
  | LABEL            { printf("--LABEL expression: EB")}
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
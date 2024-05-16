%{
#include "ensamblador.tab.h" 
#include "ensamblador.tab.c" 

#include <stdio.h>
#include <stdlib.h>

extern int yyerror(const char* s); 
#pragma warning(disable: 4267 4244 4273 4065)
int numeros = 0;

%}

%option outfile = "proyecto.cpp"

%%

"name"[ \t]*\"[^\"]*\" { /* etiquetas como name "colors" */}

"org"           { return ORG; }
"mov"           { return MOV; }
"int"           { return INToken; }
"ret"           { return RET; }
"jmp"           { return JMP; }
"jz"            { return JZ; }
"je"            { return JE; }
"inc"           { return INC; }
"cmp"           { return CMP; }
"dl"            { return DL; }
"dh"            { return DH; }
"ax"            { return AX; }
"ah"            { return AH; }
"bx"            { return BX; }
"cx"            { return CX; }
"bl"            { return BL; }
"bh"            { return BH; }

";"[^\n]*       { /* ignorar comentarios*/ }

(0x[a-fA-F0-9]+|[a-fA-F0-9]+"h") { 
    printf("--Hexadecimal: ");
    char *hex_end = strchr(yytext, 'h');  
    if (hex_end && hex_end == yytext + strlen(yytext) - 1) {  
        *hex_end = '\0'; 
    }
    printf("%s", yytext);
    printf("\n");
    return HEX_NUMBER;
    }

[0-9]+          {  
    numeros = atoi(yytext);
    unsigned int num = (unsigned int)numeros;
    printf("--Decimal: %s, Hexadecimal: %X\n", yytext, num);
    printf("\n");
    return NUMBER;
    }


'\''[^\']*\'' { /* acción para capturar caracteres entre comillas simples */ }

[a-zA-Z_][a-zA-Z0-9_]*":"|[a-zA-Z_][a-zA-Z0-9_]* {  return LABEL; }

","        { /* ignorar comas*/ }

"\n"               { /* ignorar saltos*/ }

[ \t]+        { /* ignorar espacios en blanco */ }

.               { /* ignorar caracteres no reconocidos*/ }


%%

int yywrap(void) 
{
    /*
    if (file_list[file_index] != NULL) {
        next_filename = file_list[file_index++];
        yyin = fopen(next_filename, "r");
        if (yyin == NULL) {
            return 1;  // Si el archivo no se puede abrir, termina el análisis
        }
        return 0;  // Hay más archivos para procesar
    }
    */
    return 0;  // No hay más archivos
}
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
"bx"            { return BX; }
"cx"            { return CX; }
"dx"            { return DX; }
"bl"            { return BL; }

";"[^\n]*       { /* ignorar comentarios*/ }

(0x[a-fA-F0-9]+|[a-fA-F0-9]+"h") { 
    char *ptr = yytext;
    if (ptr[0] == '0' && (ptr[1] == 'x' || ptr[1] == 'X')) {
        ptr += 2;  // Skip the '0x' prefix
    } else {
        ptr[strlen(ptr) - 1] = '\0';  // Remove the 'h' suffix
    }
    unsigned int num = strtol(ptr, NULL, 16);
    printf("--Hex: %s, Binary: ", ptr);

    // Encuentra y elimina ceros a la izquierda
    int leading = 1; // Flag para detectar el primer '1'
    for (int i = sizeof(num) * 8 - 1; i >= 0; i--) {
        if (num & (1 << i)) {
            putchar('1');
            leading = 0;
        } else if (!leading) {
            putchar('0');
        }
    }
    if (leading) { // Si el número es cero
        putchar('0');
    }
    putchar('\n');
    return HEX_NUMBER;
    }

[0-9]+          {  
    numeros = atoi(yytext);
    unsigned int num = (unsigned int)numeros;
    printf("--Decimal: %s, Binary: ", yytext);

    // Encuentra y elimina ceros a la izquierda
    int leading = 1; // Flag para detectar el primer '1'
    for (int i = sizeof(num) * 8 - 1; i >= 0; i--) {
        if (num & (1 << i)) {
            putchar('1');
            leading = 0;
        } else if (!leading) {
            putchar('0');
        }
    }
    if (leading) { // Si el número es cero
        putchar('0');
    }
    putchar('\n');
    return NUMBER;
    }

'\''[^\']*\'' { /* acción para capturar caracteres entre comillas simples */ }

[a-zA-Z_][a-zA-Z0-9_]*":"|[a-zA-Z_][a-zA-Z0-9_]* {  return LABEL; }

","        { return COMA; }

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
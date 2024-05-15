%{
#include "ensamblador.tab.h" 
#include "ensamblador.tab.c"

extern int yyerror(const char* s); //Por si no reconoce un caracter
#pragma warning(disable: )
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
"dl"            { return REG; }
"dh"            { return REG; }
"ax"            { return AX; }
"bx"            { return BX; }
"cx"            { return CX; }
"dx"            { return DX; }

";"[^\n]*       { /* ignorar comentarios*/ }

"0x"[0-9A-Fa-f]+ {  return HEX_NUMBER;}

[0-9]+          {  numeros = atoi(yytext); return NUMBER; }

'\''[^\']*\'' { /* acción para capturar caracteres entre comillas simples */ }

[a-zA-Z_][a-zA-Z0-9_]* {  return LABEL; }

"\n"               { /* ignorar saltos*/ }

","        { return COMA; }

[ \t]+        { /* ignorar espacios en blanco */ }

.               { /* caracteres no reconocidos, los ; son comentarios en ensamblador */ }


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
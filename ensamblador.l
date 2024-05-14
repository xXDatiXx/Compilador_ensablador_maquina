%{
#include "ensamblador.tab.h" 
%}

/*Definiciones de los tokens*/
    %token MOV INT RET JMP JZ JE INC CMP
    %token REG DL DH AX BX CX DX
    %token NUMBER LABEL

%%

#Patrones para registros y operadores especiales

"mov"           { return MOV; }
"int"           { return INT; }
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

#Patrón para números (hexadecimales y decimales)
[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"0x"[0-9A-Fa-f]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; }

#Patrones para etiquetas
[a-zA-Z_][a-zA-Z0-9_]* { yylval = strdup(yytext); return LABEL; }

#Espacios en blanco
[ \t\n]+        { /* ignorar espacios en blanco */ }


.               { /* caracteres no reconocidos */ }

%%

int yywrap() { return 1; }

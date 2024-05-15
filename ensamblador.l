%{
    #include "ensamblador.tab.h" 
    #include "ensamblador.tab.c"

    extern int yyerror(const char* s); //Por si no reconoce un caracter
    #pragma warning(disable: )
    int numeros = 0;

%}

%option noyywrap
%option outfile = "proyecto.cpp"

%%

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

[0-9]+          {  numeros = atoi(yytext); return NUMBER; }

"0x"[0-9A-Fa-f]+ {  return HEX_NUMBER;}

[a-zA-Z_][a-zA-Z0-9_]* {  return LABEL; }

"\n"               { return *yytext; }

","         { return *yytext; }

[ \t]+        { /* ignorar espacios en blanco */ }

.               { /* caracteres no reconocidos, los ; son comentarios en ensamblador */ }

%%
%{
    #include "ensamblador.tab.h" 

    extern int yyerror(const char* s); //Por si no reconoce un caracter
    #pragma warning(disable: 28251 6385 6011 4273 4013 4047 4267 4244 4012 4312 4273)

%}

%option noyywrap

%%

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

[0-9]+          { yylval.ival = atoi(yytext); return NUMBER; }

"0x"[0-9A-Fa-f]+ { yylval.sval = strtol(yytext, NULL, 16); return NUMBER;}

[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return LABEL; }

[ \t\n]+        { /* ignorar espacios en blanco */ }


.               { /* caracteres no reconocidos, los ; son comentarios en ensamblador */ }

%%
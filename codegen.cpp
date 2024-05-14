//Crea un archivo de C, por ejemplo, codegen.c, donde defines funciones para cada tipo de instrucción que tu compilador necesita soportar.
//Cada función en codegen.c será responsable de convertir una instrucción de alto nivel o ensamblador en su correspondiente código de máquina para la arquitectura objetivo.

#include "codegen.h"

codegen::codegen(){
    create_file();
};

char* my_strdup(const char* s) {
    char* new_str = (char*) malloc(strlen(s) + 1); // +1 for the null-terminator
    if (new_str) {
        strcpy(new_str, s);
    }
    return new_str;
}

void create_file() {
    //Crea un documento de texto
    ofstream file;
    file.open("codigoTraducidoMaquina.txt");
    file.close();

}

void write_file(string textoMaquina) {
    //Escribe en el documento de texto
    ofstream file;
    file.open("codigoTraducidoMaquina.txt", ios::app);
    file << textoMaquina << endl;
    file.close();
}

void mov(){
    write_file("100010");
}

void int_(){
    write_file("");
}

void ret(){
    write_file("");

}

void jmp(){
    write_file("");
}

void jz(){
    write_file("");
}

void je(){
    write_file("");
}

void inc(){
    write_file("");
}

void cmp(){
    write_file("");
}

void reg(){
    write_file("");
}

void ax(){
    write_file("");
}

void bx(){
    write_file("");
}

void cx(){
    write_file("");
}

void dx(){
    write_file("");
}

void dh(){
    write_file("");
}
void dl(){
    write_file("");
}


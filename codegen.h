#pragma once
using namespace std;
#include <iostream>
#include <string>
#include <fstream> // Incluye soporte para flujos de archivos


class codegen
{
public:
	//Aqui se ponen los títulos de la funciones
    char* my_strdup();
    void mov();
    void int_();
    void ret();
    void jmp();
    void jz();
    void je();
    void inc();
    void cmp();
    void reg();
    void ax();
    void bx();
    void cx();
    void dx();
    void dh();
    void dl();

private:
    void create_file();
    void write_file(string);
};


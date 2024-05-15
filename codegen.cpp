#include "codegen.h"

CodeGen::CodeGen(const std::string& filename) {
    outFile.open(filename);
    if (!outFile.is_open()) {
        throw std::runtime_error("Unable to open file: " + filename);
    }
}

CodeGen::~CodeGen() {
    if (outFile.is_open()) {
        outFile.close();
    }
}

char* my_strdup(const char* s) {
    char* new_str = (char*) malloc(strlen(s) + 1); // +1 for the null-terminator
    if (new_str) {
        strcpy(new_str, s);
    }
    return new_str;
}

void CodeGen::generateMovCode(const std::string& destReg, const std::string& srcReg) {
    outFile << "MOV " << destReg << ", " << srcReg << "\n";
}

void CodeGen::generateIntCode(int interruptNumber) {
    outFile << "INT 0x" << std::hex << interruptNumber << "\n";
}

void CodeGen::generateJmpCode(const std::string& label) {
    outFile << "JMP " << label << "\n";
}

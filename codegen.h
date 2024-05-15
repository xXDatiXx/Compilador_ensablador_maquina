#pragma once
#include <fstream>

class CodeGen {
    public:
        explicit CodeGen(const std::string& filename);
        ~CodeGen();

        void generateMovCode(const std::string& destReg, const std::string& srcReg);
        void generateIntCode(int interruptNumber);
        void generateJmpCode(const std::string& label);
        char* my_strdup(const char*);

    private:
        std::ofstream outFile;
};

#include "print.h"

struct Char {
    uint8_t character;
};

struct Char* buffer = (struct Char*) 0x8C000000;

void print_char(char character){

    buffer[100] = (struct Char){
        character: (uint8_t) character,
    };
}

void print_str(char* str){
    for(size_t i=0; 1; i++){
        char character = (uint8_t) str[i];
        if(character == '\0'){
            return;
        }
        print_char(character);
    }
}
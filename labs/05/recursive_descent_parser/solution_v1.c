#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

/***************************
Example:
Grammar:
E --> T | T + E
T --> int | int * T | (E) 
***************************/

char l;

bool E();
bool T();

bool match(char t);
bool isInt();
void error();

void error(){
	printf("Error\n");
	exit(-1);
}

// Match function
bool match(char t) {
    if (l == t) {
        l = getchar();
		return true;
    }
    else
		error();
}

bool isInt(){
	if(isdigit(l) == true){
		l =  getchar();
		return true;
	} else {
		return false;
	}
}

// Definition of E, as per the given production
bool E() {
	if (T() || (T() && match('+') && E()) /* T + E */) {
		return true;
	}else{
		error();
	}
}

// Definition of T, as per the given production
bool T() {
	if (isInt() || (isInt() && match('*') && T()) /* int * T()  */ || (match('(') && E() && match(')'))) /* (E) */ {
		return true;
	}else{
		error();
	}
}

int main() {

    do {
        l = getchar();
		// E is a start symbol.
	    E();

    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
}

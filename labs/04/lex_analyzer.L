%{
#include <stdio.h>
int yywrap() {
    return 1;
}
%}

%%

"//"[^\n]*   { printf("COMMENT\n"); } // Captura todo el comentario hasta el final de la línea
"f"          { printf("floatdcl "); } // Detecta declaración de variable tipo float
"i"          { printf("intdcl "); }   // Detecta declaración de variable tipo int
"p"          { printf("print "); }    // Imprimir comando
"="          { printf("assign "); }   // Asignación
"+"          { printf("plus "); }     // Operador de suma
[a-zA-Z]+    { printf("id "); }       // Identificadores (variable)
[0-9]+       { printf("inum "); }     // Números enteros
[0-9]+"."[0-9]+ { printf("fnum "); }  // Números flotantes
\n           { printf("\n"); }        // Nueva línea para mantener salida ordenada
[ \t]+       { /* ignora espacios y tabulaciones */ }
.            { /* ignora cualquier otro carácter individual no capturado */ }

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (yyin == NULL) {
            fprintf(stderr, "Error opening file: %s\n", argv[1]);
            return 1;
        }
    } else {
        yyin = stdin;
    }

    yylex();

    if (yyin != stdin) {
        fclose(yyin);
    }

    return 0;
}


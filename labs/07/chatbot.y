%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME MOOD WEATHER

%%

chatbot : greeting
        | farewell
        | query
	| identity
        | mood
        | weather
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;


identity : NAME { printf("Chatbot: My name is Chatbot.\n"); }
         ;

mood : MOOD { printf("Chatbot: I'm just a program, so I don't have feelings, but thank you for asking!\n"); }
     ;

weather : WEATHER { printf("Chatbot: I'm not sure about the weather, but you can check online!\n"); }
        ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}


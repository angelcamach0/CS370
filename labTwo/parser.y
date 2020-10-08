/*****
* Yacc parser for simple example
*
* The grammar in this example is:
* all -> phrases
* phrases -> <empty>
* phrases -> phrases NUMBER PLUS NUMBER
* phrases -> phrases NUMBER
* phrases -> phrases OTHER
* 
* The tokens that come from the scanner are: NUMBER, PLUS, and OTHER. 
* The scanner skips all whitespace (space, tab, newline, and carriage return).
* The lexemes of the token NUMBER are strings of digits ('0'-'9'). 
* The lexeme of PLUS is only a string consisting of the plus symbol ('+').
* The lexemes of the token OTHER are strings of characters that do not 
* include whitespace, digits, or the plus symbol.
* 
* Given the input "acb 42 +34 52this is", the scanner would produce 
* the tokens(/lexemes) of:
* <OTHER,"abc">, <NUMBER,"42">, <PLUS,"+">, <NUMBER,"34">, <NUMBER,"52">,
* <OTHER,"this">, <OTHER,"is">
* 
* and this would match the grammar.
*****/

/****** Header definitions ******/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// function prototypes from lex
int yyerror(char *s);
int yylex(void);
int addString(char *str);
//int debug=0; // set to 1 to turn on extra printing

//sorry for using an array please dont take too many points off :(
char* stringArr[100]; 
char* codeArr[100];   
int stringCount = 0;  
int statementCount = 0; 
%}

/* token value data types */
%union { int ival; char* str; }

/* Starting non-terminal */
%start prog
%type <str> function statements statement funcall

/* Token types */
%token <ival> NUMBER COMMA SEMICOLON LPAREN RPAREN LBRACE RBRACE
%token <str> ID STRING 

%%
/******* Rules *******/

prog: function 
     {
         // P main program lines 
         printf("\t.file\"test.c\"\n\t.section\t.rodata\n");
         // string constants declarations 
         for(int i=0; i<stringCount; i++)
         {
            printf(".LC%d:\n\t.string %s\n", i, stringArr[i]);
         }
         // P main program lines
         printf("\t.text\n");
         // H for function header lines 
         printf("\t.globl main\n\t.type main, @function\nmain:\n\tpushq %%rbp\n\tmovq %%rsp, %%rbp\n");

         // S print statments
         for(int i=0; i<statementCount; i++)
         {
            printf("%s", codeArr[i]);
         }
         // F for function footer lines
         printf("\tmovl $0, %%eax\n\tpopq %%rbp\n\tret\n");
     }
   
function: ID LPAREN RPAREN LBRACE statements RBRACE
     {  
       $$ = $5;
     }
     
statements: statement statements
     {  
        $$ = $1;
     }
     | 
     {$$ = "empty";}
statement: funcall
     {
         $$ = $1;
     }
     
funcall: ID LPAREN STRING RPAREN SEMICOLON
     {
      int idIndex = addString($3);
      char *code = (char*) malloc(128);
      sprintf(code,"\tmovl\t$.LC%d, %%edi\n\tcall\t%s\n",idIndex,$1);
      codeArr[statementCount] = code; 
      statementCount++; 
      $$ = code;
     }
;
%%
/******* Functions *******/
extern FILE *yyin; // from lex

int main(int argc, char **argv)
{
   if (argc==2) {
      yyin = fopen(argv[1],"r");
      if (!yyin) {
         printf("Error: unable to open file (%s)\n",argv[1]);
         return(1);
      }
   }
   return(yyparse());
}

//extern int yylineno; // from lex

int yyerror(char *s)
{
   fprintf(stderr, "Error: line %s\n",s);
   return 0;
}

int addString ( char *str ){ 
  int returnIndex = stringCount;
  stringArr[stringCount] = str;
  stringCount++;
  return returnIndex;
}

int yywrap()
{
   return(1);
}




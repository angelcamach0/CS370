/****
* Lex scanner for simple example
****/

/****** Header definitions ******/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef LEXONLY
// definitions auto-created by yacc (when using yacc)
#include "y.tab.h"
#else
// explicit definitions for standalone mode
typedef union { int ival; char* str; } yystype;
#define YYSTYPE yystype
yystype yylval;
#define NUMBER 1
#define COMMA   2
#define SEMICOLON 3
#define LPAREN 4
#define RPAREN 5
#define LBRACE 6
#define RBRACE 7
#define ID 8
#define STRING 9
#endif
//extern int debug; // declared and set in parser.y
%}

/****** Token Patterns ******/
/*** I was not sure if I wa**/
%%
[ \t\n\r]* { /* skipping white space */ }
[1-9][0-9]*   {
               yylval.ival = strtol(yytext,0,10);
               return (NUMBER);
              } 
\,            {
               yylval.ival = yytext[0];
               return (COMMA);
              } 
\;            {
               yylval.ival = yytext[0];
               return (SEMICOLON);
              }
\(            {
                yylval.ival = yytext[0];
                return (LPAREN);
              }
\)            {
               yylval.ival = yytext[0];
               return (RPAREN);
              }
\{           {
               yylval.ival = yytext[0];
               return (LBRACE);
              }
\}           {
               yylval.ival = yytext[0];
               return (RBRACE);
              }
[a-zA-Z][a-zA-Z0-9]*  {
                        yylval.str = strdup(yytext); 
                        return(ID);
                      }
\".*\"                {
                        yylval.str = strdup(yytext);
                        return(STRING);
                      }

%%
/****** Functions (not used when used with parser) *******/

//
// Code in the ifdef block below is only for compiling the
// scanner all by itself, for testing purposes. The 
// Makefile shows how to compile it under the "ltest" rule
// (do "make ltest" to build it)
//
#ifdef LEXONLY
// A main for standalone testing (uses just stdin as input)
int main(int argc, char **argv) 
{
   do {
      yylex();
   } while (1);
   // while (!feof(stdin)); doesn't work if redirecting a file
   // in because the file is read in and buffered, and eof is
   // true too early, causing lex to stop; rather, use while(1)
   // and then do a hard exit in yywrap(); ugly, but works!
   return 0;
}

int yywrap()
{
   exit(0); // hard exit!
   //return(1);
}

#endif // LEXONLY


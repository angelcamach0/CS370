
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// make the function that reads the file
int countWordsAndLines(char **argv){
    char **fileNameInput = argv;
    int words = 0;
    int lines = 0;
    //read file
    
    //loop throught the file until there no more lines
        //loop through characters
            //if there is a " " && prevWhitSspace != true
              // words++;
              // preWhiteSpace = true
            //if there is NOT a " "
                //preWhiteSpeace = false;
        //ending unknown
    lines++;
    //ending unknown

    // return two values or just make like a pointer or something

}

int main(int argc, char **argv){
    char nameOfFile[69] = "";
    int input = 2;
    printf("Type \"1\" for coustum file\n");
    printf("Type \"0\" for default file\n");
    //scan input
    scanf("%d", input);
    // if input zero

    if( input == 0 ){
        printf("Reading default file..");

    }
    // if input 1
    if( input == 1 ){
        printf("Please enter the name of the file: ");
        //Scan fileNameInput
        scanf("%s", nameOfFile);
        printf("Your chosen file is: %s", nameOfFile);
        FILE * filePoitner;
        fpointer = fopen(nameOfFile, "r");

    }
    // otherwise
    else{
        printf("That is not a valid input!\n");
        printf("Try again! you may only input \"1\" or \"0\" !");
        return;
    }

}
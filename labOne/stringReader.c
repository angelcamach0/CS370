// Angel Camacho
// CS370 Lab One String Proccesing
// Aug 27, 2020

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countWords(char line[1024], int *w){
    // variables and setting token
    char * tokens;
    *w = 0;
    printf("%d\n", w);
    tokens = strtok(line, " \t\n\r");
    // as long as its not the end of the file
    while(tokens != NULL){
        w = w + 1;
        while(w != ' '){
            printf("letter");
        }
        tokens = strtok(NULL, " \t\n\r");
    }
    return 0;
}

int main(int argc, char **argv){
    char nameOfFile[69] = "";
    
    printf("Type \"1\" for coustom file\n");
    printf("Type \"0\" for default file\n");
    
    //scan input
    int input;
    scanf("%d", &input);
    
    // if input zero
    if( input == 0 ){
        printf("Reading default file..");
    }else if( input == 1 ){
        printf("Please enter the name of the file: \n");

        //Scan fileNameInput
        scanf("%s", nameOfFile);
        printf("Your chosen file is: %s\n", nameOfFile);
        FILE * filePointer;
        filePointer = fopen(nameOfFile, "r");
        // incase there is an error
        if(filePointer == 0){
            printf("File Error\n");
            return -1;
        }
        int words = 0;
        int numberOfLines = 0;
        char line[1024];
        int w = 0;

        // the actuall counter of lines and words
        
            while(!feof(filePointer)){
                fgets(line, 1024, filePointer);
                countWords(line, &w);
                words = words + w;
                numberOfLines = numberOfLines + 1;
            }
            printf("Number Of Words: %d\n", words);
            printf("Number Of Lines: %d\n", numberOfLines);
            return 0;
    }
    // otherwise
    else{
        printf("That is not a valid input!\n");
        printf("Try again! you may only input \"1\" or \"0\" !");
        return -1;
    }

}

// // // make the function that reads the file
// int countWordsAndLines(char **argv){
//     char **fileNameInput = argv;
//     int words = 0;
//     int lines = 0;
//     //read file
    
//     //loop throught the file until there no more lines
//         //loop through characters
//             //if there is a " " && prevWhitSspace != true
//               // words++;
//               // preWhiteSpace = true
//             //if there is NOT a " "
//                 //preWhiteSpeace = false;
//         //ending unknown
//     lines++;
//     //ending unknown

//     // return two values or just make like a pointer or something

// }



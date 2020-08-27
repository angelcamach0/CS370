// This is my cs370 lab 
#include <stdio.h>
#include <string.h>


int main(int argc, char *argv[])
{

    FILE *inf;
    char str[1024];
    inf = fopen(argv[1],"r");
    if (inf == 0){
        printf("Error opening file!\n");
        return -1;
    }

    // This is the part where you print the program.
    while(NULL != fgets(str, sizeof(str), inf)){
        int i = strlen(str);
        if(str[i-1] == '\n');
        str[i-1] = '\0';
        printf("(%s)\n",str);
    }

    // fgets(str, 1024,inf);
    // printf("(%s)\n",str);
    fclose(inf);
    printf("Hello World!\n");
    return 0;
}


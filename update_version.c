#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (int argc, char *argv[]) {
    if (argc!=2) {
        printf("usage: ./update_version <version_string>\n");
        exit(-1);
    }
    time_t now = time(NULL);
    struct tm *nowStruct = localtime(&now);
    char *timeStr = asctime(nowStruct);
    printf("// Version.h \n// project-a-ios \n// \n// Created by Mike Bell on %s\n#define GAME_VERSION @\"%s\"\n", timeStr, argv[1]);
    return 0;
}

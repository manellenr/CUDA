#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <unistd.h>
#include <time.h>

void permuter(int *a, int *b) {
    int tmp;
    tmp = *a;
    *a = *b;
    *b = tmp;
}

void triRapid(int tab[], int first, int last) {
    int pivot, i, j;

    if(first < last) {
        pivot = first;
        i = first;
        j = last;
        while (i < j) {
            while(tab[i] <= tab[pivot] && i < last)
                i++;
            while(tab[j] > tab[pivot])
                j--;
            if(i < j) {
                permuter(&tab[i], &tab[j]);
            }
        }
        permuter(&tab[pivot], &tab[j]);
        triRapid(tab, first, j - 1);
        triRapid(tab, j + 1, last);
    }
}

int main() {
    int n = 1000000;
    int tab[n], nbr = 1000000, i, j;
    float temps;
    clock_t t1, t2;

    srand(time(NULL));
    for(j = 0; j < n; j++){
        tab[j] = rand() % 1000000 + 1;
    }

    t1 = clock();
    triRapid(tab, 0, nbr - 1);
    t2 = clock();

    printf("Sorted array: \n");
    for(i = 0; i < nbr; i++)  {
        printf(" %4d", tab[i]);
    }
    printf("\n");
    temps = (float)(t2-t1)/CLOCKS_PER_SEC;
    printf("CPU execution time = %f s\n", temps);  
    return 0;
}

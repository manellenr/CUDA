#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

#define N 1000000
#define BLOCK_SIZE 256

__device__ void permuter(int *a, int *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

__device__ int partition(int *arr, int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            permuter(&arr[i], &arr[j]);
        }
    }
    permuter(&arr[i + 1], &arr[high]);
    return (i + 1);
}

__global__ void quickSortKernel(int *arr, int low, int high) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    if (low < high) {
        int pivotIndex = partition(arr, low, high);

        if (pivotIndex - 1 > low && pivotIndex - 1 > idx) {
            quickSortKernel<<<1, BLOCK_SIZE>>>(arr, low, pivotIndex - 1);
        }
        if (pivotIndex + 1 < high && pivotIndex + 1 < idx) {
            quickSortKernel<<<1, BLOCK_SIZE>>>(arr, pivotIndex + 1, high);
        }
    }
}

int main() {
    int *arr, *d_arr;
    int n = N;
    srand(time(NULL));

    arr = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 1000000 + 1;
    }

    cudaMalloc((void**)&d_arr, n * sizeof(int));
    cudaMemcpy(d_arr, arr, n * sizeof(int), cudaMemcpyHostToDevice);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    quickSortKernel<<<(n + BLOCK_SIZE - 1) / BLOCK_SIZE, BLOCK_SIZE>>>(d_arr, 0, n - 1);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("GPU execution time = %f s\n", milliseconds / 1000);

    cudaMemcpy(arr, d_arr, n * sizeof(int), cudaMemcpyDeviceToHost);

    printf("Sorted array:\n");
    for (int i = 0; i < n; i++) {
        printf(" %d", arr[i]);
    }
    printf("\n");

    free(arr);
    cudaFree(d_arr);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return 0;
}

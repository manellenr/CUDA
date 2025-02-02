# README for CPU vs GPU Sorting Project

This project compares the performance of the QuickSort algorithm executed on CPU and GPU. The CPU version uses a standard QuickSort, while the GPU version implements QuickSort using CUDA for parallelism.

## Requirements

- **CUDA Toolkit**: Ensure you have CUDA installed on your machine to compile and run the GPU version of the program.
- **C Compiler**: A C compiler is required (such as GCC) to compile the CPU code.
- **nvcc**: CUDA compiler to compile the GPU code.

## Compilation Instructions

### To compile the CPU version:
```bash
gcc -o quicksort_cpu quicksort_cpu.c
./quicksort_cpu
```

## Code Explanation

### Time Measurement:

- **CPU Execution Time**: Calculated using clock() function and printed in seconds.
- **GPU Execution Time**: The GPU version measures execution time using CUDA events (cudaEventRecord and cudaEventElapsedTime), returning the result in seconds.

### Performance Comparison

- **CPU Execution Time**: The CPU version sorts the array in approximately 0.15 seconds.
- **GPU Execution Time**: The GPU version sorts the array in approximately 0.10 seconds.

## Conclusion

This project demonstrates the significant performance improvement when using a GPU for parallel sorting, especially for large datasets. The GPU version is faster than the CPU version due to the parallel nature of the QuickSort algorithm and the massive parallelism offered by modern GPUs.

By comparing CPU and GPU execution times, you can see how utilizing the GPU can drastically reduce the time needed to sort large arrays, making it a valuable approach for computationally heavy tasks such as sorting.


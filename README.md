# Parallelization from CPU to GPU: QuickSort Algorithm

The goal is to compare the performance of the QuickSort algorithm executed on the CPU and then on the GPU. The GPU version implements QuickSort using CUDA.

### To compile the CPU version:

```bash
gcc -o quicksort_cpu quicksort_cpu.c
./quicksort_cpu
```

### Performance Comparison

* **CPU Execution Time**: The CPU version sorts the array in approximately 0.15 seconds.
* **GPU Execution Time**: The GPU version sorts the array in approximately 0.10 seconds.

## Conclusion

By comparing CPU and GPU execution times, we observe that using the GPU significantly reduces the time needed to sort large arrays, making it a valuable approach for computationally intensive tasks such as sorting.

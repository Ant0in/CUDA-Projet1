
#include "benchmarks.cuh"
#include "kernels.cuh"
#include "cuda_utils.cuh"

#include <iostream>

#define BLOCK_SIZE 256

Benchmark::Benchmark() {

    // benchmark constructor. i choose to print device info here because it only needs to be done once, 
    // but it could very well be done in main() or somewhere else. im just a bad dev ig :D
    cuda_utils::printDeviceInfo();

}

/**
 * @brief Run the vector addition benchmark for a given size n.
 * 
 * This method allocates memory for three vectors (a, b, c) on the GPU, launches the vector addition kernel, and measures its execution time.
 * It then calculates the GFLOPS achieved and prints the results to the console. Finally, it frees the allocated GPU memory.
 * @param n The size of the vectors to be added
 */
void Benchmark::runAddition(int n) {

    float *d_a, *d_b, *d_c;
    size_t size = n * sizeof(float);

    // mallocating memory on the GPU for the input and output vectors
    cuda_utils::checkCudaError(cudaMalloc(&d_a, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_b, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_c, size));

    // grid and block dimensions for launching the kernel
    dim3 block(BLOCK_SIZE);
    dim3 grid((n + block.x - 1) / block.x);

    // measure the execution time of the vector addition kernel
    float ms = cuda_utils::measure([&]() {
        kernels::vecAdd<<<grid, block>>>(d_a, d_b, d_c, n);
    });

    float seconds = ms / 1000.0f;
    float gflops = (n / seconds) / 1e9f;

    std::cout << "Add, N=" << n
              << ", time=" << ms
              << " ms, GFLOPS=" << gflops
              << std::endl;

    // free the allocated GPU memory
    cuda_utils::checkCudaError(cudaFree(d_a));
    cuda_utils::checkCudaError(cudaFree(d_b));
    cuda_utils::checkCudaError(cudaFree(d_c));

}

/**
 * @brief Run the vector multiplication benchmark for a given size n.
 * 
 * This method allocates memory for three vectors (a, b, c) on the GPU, launches the vector multiplication kernel, and measures its execution time.
 * It then calculates the GFLOPS achieved and prints the results to the console. Finally, it frees the allocated GPU memory.
 * @param n The size of the vectors to be multiplied
 */
void Benchmark::runMultiplication(int n) {

    float *d_a, *d_b, *d_c;
    size_t size = n * sizeof(float);

    // mallocating memory on the GPU for the input and output vectors
    cuda_utils::checkCudaError(cudaMalloc(&d_a, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_b, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_c, size));

    // grid and block dimensions for launching the kernel
    dim3 block(BLOCK_SIZE);
    dim3 grid((n + block.x - 1) / block.x);

    // measure the execution time of the vector multiplication kernel
    float ms = cuda_utils::measure([&]() {
        kernels::vecMul<<<grid, block>>>(d_a, d_b, d_c, n);
    });

    float seconds = ms / 1000.0f;
    float gflops = (n / seconds) / 1e9f;

    std::cout << "Mul, N=" << n
              << ", time=" << ms
              << " ms, GFLOPS=" << gflops
              << std::endl;

    // free the allocated GPU memory
    cuda_utils::checkCudaError(cudaFree(d_a));
    cuda_utils::checkCudaError(cudaFree(d_b));
    cuda_utils::checkCudaError(cudaFree(d_c));

}

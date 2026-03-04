
#include "benchmarks.cuh"
#include "kernels.cuh"
#include "cuda_utils.cuh"

#include <iostream>

#define BLOCK_SIZE 256
#define NUM_RUNS 10

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
 * @param k The number of operations to perform for each element to increase the computational load
 */
float Benchmark::runAddition(int n, int k) {

    float *d_a, *d_b, *d_c;
    size_t size = n * sizeof(float);

    // mallocating memory on the GPU for the input and output vectors
    cuda_utils::checkCudaError(cudaMalloc(&d_a, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_b, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_c, size));

    // memset the input vectors to some values (i.e. 1.0f)
    cuda_utils::checkCudaError(cudaMemset(d_a, 1.0f, size));
    cuda_utils::checkCudaError(cudaMemset(d_b, 1.0f, size));

    // grid and block dimensions for launching the kernel
    dim3 block(BLOCK_SIZE);
    dim3 grid((n + block.x - 1) / block.x);

    float totalMs = 0.0f;

    // measure the execution time of the vector addition kernel
    for (int i = 0; i < NUM_RUNS; i++) {
        totalMs += cuda_utils::measure([&]() {
            kernels::vecAdd<<<grid, block>>>(d_a, d_b, d_c, n, k);
        });
    }

    float ms = totalMs / NUM_RUNS;
    float seconds = ms / 1000.0f;
    float totalFlops = (float)n * k;
    float gflops = (totalFlops / seconds) / 1e9f;
    float bytes = 3.0f * n * sizeof(float);
    float bandwidth = (bytes / seconds) / 1e9f;

    std::cout << "Addition - Size: " << n << ", Time: " << ms << " ms, GFLOPS: " << gflops << ", Bandwidth: " << bandwidth << " GB/s"<<" , K :" << k << std::endl;

    // free the allocated GPU memory
    cuda_utils::checkCudaError(cudaFree(d_a));
    cuda_utils::checkCudaError(cudaFree(d_b));
    cuda_utils::checkCudaError(cudaFree(d_c));

    return gflops;
}

/**
 * @brief Run the vector multiplication benchmark for a given size n.
 * 
 * This method allocates memory for three vectors (a, b, c) on the GPU, launches the vector multiplication kernel, and measures its execution time.
 * It then calculates the GFLOPS achieved and prints the results to the console. Finally, it frees the allocated GPU memory.
 * @param n The size of the vectors to be multiplied
 * @param k The number of operations to perform for each element to increase the computational load
 */
float Benchmark::runMultiplication(int n, int k) {

    float *d_a, *d_b, *d_c;
    size_t size = n * sizeof(float);

    // mallocating memory on the GPU for the input and output vectors
    cuda_utils::checkCudaError(cudaMalloc(&d_a, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_b, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_c, size));

    // memset the input vectors to some values (i.e. 1.0f)
    cuda_utils::checkCudaError(cudaMemset(d_a, 1.0f, size));
    cuda_utils::checkCudaError(cudaMemset(d_b, 1.0f, size));

    // grid and block dimensions for launching the kernel
    dim3 block(BLOCK_SIZE);
    dim3 grid((n + block.x - 1) / block.x);

    float totalMs = 0.0f;

    // measure the execution time of the vector multiplication kernel
    for (int i = 0; i < NUM_RUNS; i++) {
        totalMs += cuda_utils::measure([&]() {
            kernels::vecMul<<<grid, block>>>(d_a, d_b, d_c, n, k);
        });
    }

    float ms = totalMs / NUM_RUNS;
    float seconds = ms / 1000.0f;
    float totalFlops = (float)n * k;
    float gflops = (totalFlops / seconds) / 1e9f;
    float bytes = 3.0f * n * sizeof(float);
    float bandwidth = (bytes / seconds) / 1e9f;

    std::cout << "Multiplication - Size: " << n << ", Time: " << ms << " ms, GFLOPS: " << gflops << ", Bandwidth: " << bandwidth << " GB/s" << ", K: " << k << std::endl;

    // free the allocated GPU memory
    cuda_utils::checkCudaError(cudaFree(d_a));
    cuda_utils::checkCudaError(cudaFree(d_b));
    cuda_utils::checkCudaError(cudaFree(d_c));

    return gflops;
}

/**
 * @brief Run the vector addition benchmark with j elements per thread for a given size n.
 * 
 * This method allocates memory for three vectors (a, b, c) on the GPU, launches the vector addition kernel that processes j elements per thread, and measures its execution time.
 * It then calculates the GFLOPS achieved and prints the results to the console. Finally, it frees the allocated GPU memory.
 * @param n The size of the vectors to be added
 * @param j The number of elements each thread should process
 * @param k The number of times to run the kernel for averaging
 */
float Benchmark::runAdditionJ(int n, int j, int k) {

    float *d_a, *d_b, *d_c;
    size_t size = n * sizeof(float);

    // mallocating memory on the GPU for the input and output vectors
    cuda_utils::checkCudaError(cudaMalloc(&d_a, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_b, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_c, size));

    // memset the input vectors to some values (i.e. 1.0f)
    cuda_utils::checkCudaError(cudaMemset(d_a, 1.0f, size));
    cuda_utils::checkCudaError(cudaMemset(d_b, 1.0f, size));

    // grid and block dimensions for launching the kernel
    dim3 block(BLOCK_SIZE);
    dim3 grid((n + block.x * j - 1) / (block.x * j));

    float totalMs = 0.0f;

    // measure the execution time of the vector addition kernel with j elements per thread
    for (int i = 0; i < NUM_RUNS; i++) {
        totalMs += cuda_utils::measure([&]() {
            kernels::vecAddJ<<<grid, block>>>(d_a, d_b, d_c, n, j, k);
        });
    }

    float ms = totalMs / NUM_RUNS;
    float seconds = ms / 1000.0f;
    float totalFlops = (float)n * k;
    float gflops = (totalFlops / seconds) / 1e9f;
    float bytes = 3.0f * n * sizeof(float);
    float bandwidth = (bytes / seconds) / 1e9f;

    std::cout << "AdditionJ - Size: " << n << ", J: " << j << ", Time: " << ms << " ms, GFLOPS: " << gflops << ", Bandwidth: " << bandwidth << " GB/s" << ", K: " << k << std::endl;

    // free the allocated GPU memory
    cuda_utils::checkCudaError(cudaFree(d_a));
    cuda_utils::checkCudaError(cudaFree(d_b));
    cuda_utils::checkCudaError(cudaFree(d_c));

    return gflops;
}

/**
 * @brief Run the vector multiplication benchmark with j elements per thread for a given size n.
 * 
 * This method allocates memory for three vectors (a, b, c) on the GPU, launches the vector multiplication kernel that processes j elements per thread, and measures its execution time.
 * It then calculates the GFLOPS achieved and prints the results to the console. Finally, it frees the allocated GPU memory.
 * @param n The size of the vectors to be multiplied
 * @param j The number of elements each thread should process
 * @param k The number of times to run the kernel for averaging
 */
float Benchmark::runMultiplicationJ(int n, int j, int k) {

    float *d_a, *d_b, *d_c;
    size_t size = n * sizeof(float);

    // mallocating memory on the GPU for the input and output vectors
    cuda_utils::checkCudaError(cudaMalloc(&d_a, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_b, size));
    cuda_utils::checkCudaError(cudaMalloc(&d_c, size));

    // memset the input vectors to some values (i.e. 1.0f)
    cuda_utils::checkCudaError(cudaMemset(d_a, 1.0f, size));
    cuda_utils::checkCudaError(cudaMemset(d_b, 1.0f, size));

    // grid and block dimensions for launching the kernel
    dim3 block(BLOCK_SIZE);
    dim3 grid((n + block.x * j - 1) / (block.x * j));

    float totalMs = 0.0f;

    // measure the execution time of the vector multiplication kernel with j elements per thread
    for (int i = 0; i < NUM_RUNS; i++) {
        totalMs += cuda_utils::measure([&]() {
            kernels::vecMulJ<<<grid, block>>>(d_a, d_b, d_c, n, j, k);
        });
    }

    float ms = totalMs / NUM_RUNS;
    float seconds = ms / 1000.0f;
    float totalFlops = (float)n * k;
    float gflops = (totalFlops / seconds) / 1e9f;
    float bytes = 3.0f * n * sizeof(float);
    float bandwidth = (bytes / seconds) / 1e9f;

    std::cout << "MultiplicationJ - Size: " << n << ", J: " << j << ", Time: " << ms << " ms, GFLOPS: " << gflops << ", Bandwidth: " << bandwidth << " GB/s" <<", k :"<<k<< std::endl;

    // free the allocated GPU memory
    cuda_utils::checkCudaError(cudaFree(d_a));
    cuda_utils::checkCudaError(cudaFree(d_b));
    cuda_utils::checkCudaError(cudaFree(d_c));

    return gflops;
}

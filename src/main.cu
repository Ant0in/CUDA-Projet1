#include <iostream>
#include "main.cuh"


__global__ void vecAdd(const float* a, const float* b, float* c, int n) {

    /**
     * Main CUDA kernel to perform vector addition.
     * It computes vector c as the element-wise sum of vectors a and b.
     * Each thread computes one element of the output vector c.
     */

    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < n)
        c[idx] = a[idx] + b[idx];

}

void launchVecAdd(const float* a, const float* b, float* c, int n) {

    /**
     * Host function to set up and launch the CUDA kernel for vector addition.
     * It allocates device memory, copies input data to the device, launches the kernel,
     * and then copies the result back to the host.
     */

    float *d_a, *d_b, *d_c;

    size_t size = n * sizeof(float);

    // TODO: Add error checking as asked in the TPs slides
    cudaMalloc(&d_a, size);
    cudaMalloc(&d_b, size);
    cudaMalloc(&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    int blocksPerGrid = (n + threadsPerBlock - 1) / threadsPerBlock;

    vecAdd<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c, n);
    cudaDeviceSynchronize();

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

}

int main(int argc, char* argv[]) {

    int n = 1024;
    float *a = new float[n];
    float *b = new float[n];
    float *c = new float[n];

    for (int i = 0; i < n; i++) {
        a[i] = i;
        b[i] = 2 * i;
    }

    // kernel launch
    launchVecAdd(a, b, c, n);

    // sample result check
    std::cout << "c[42] = " << c[42] << std::endl;

    delete[] a;
    delete[] b;
    delete[] c;

    return 0;

}

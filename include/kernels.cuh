
#pragma once

#include <cuda_runtime.h>

namespace kernels {

    /**
     * @brief CUDA kernel to perform vector addition.
     * It computes vector c as the element-wise sum of vectors a and b.
     * 
     * @param a Input vector a
     * @param b Input vector b
     * @param c Output vector c (result of a + b)
     * @param n Size of the vectors
     * @param k Number of additional operations to perform for each element
     */
    __global__ void vecAdd(const float* a, const float* b, float* c, int n, int k);

    /**
     * @brief CUDA kernel to perform vector multiplication.
     * It computes vector c as the element-wise product of vectors a and b.
     * 
     * @param a Input vector a
     * @param b Input vector b
     * @param c Output vector c (result of a * b)
     * @param n Size of the vectors
     * @param k Number of additional operations to perform for each element
     */
    __global__ void vecMul(const float* a, const float* b, float* c, int n, int k);

    /**
     * @brief CUDA kernel to perform vector addition with j elements for each thread.
     * It computes vector c as the element-wise sum of vectors a and b, but each thread processes j elements instead of 1.
     * 
     * @param a Input vector a
     * @param b Input vector b
     * @param c Output vector c (result of modified a + b)
     * @param n Size of the vectors
     * @param j Number of elements each thread should process
     * @param k Number of additional operations to perform for each element
     */
    __global__ void vecAddJ(const float* a, const float* b, float* c, int n, int j, int k);

    /**
     * @brief CUDA kernel to perform vector multiplication with j elements for each thread.
     * It computes vector c as the element-wise product of vectors a and b, but each thread processes j elements instead of 1.
     * 
     * @param a Input vector a
     * @param b Input vector b
     * @param c Output vector c (result of modified a * b)
     * @param n Size of the vectors
     * @param j Number of elements each thread should process
     * @param k Number of additional operations to perform for each element
     */
    __global__ void vecMulJ(const float* a, const float* b, float* c, int n, int j, int k);

};
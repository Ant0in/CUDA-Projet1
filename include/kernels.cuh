
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
     */
    __global__ void vecAdd(const float* a, const float* b, float* c, int n);

    /**
     * @brief CUDA kernel to perform vector multiplication.
     * It computes vector c as the element-wise product of vectors a and b.
     * 
     * @param a Input vector a
     * @param b Input vector b
     * @param c Output vector c (result of a * b)
     * @param n Size of the vectors
     */
    __global__ void vecMul(const float* a, const float* b, float* c, int n);

};

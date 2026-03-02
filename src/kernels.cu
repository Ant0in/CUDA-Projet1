
#include "kernels.cuh"

namespace kernels {

    __global__ void vecAdd(const float* a, const float* b, float* c, int n) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;

        if (idx < n) {
            c[idx] = a[idx] + b[idx];
        }

    }

    __global__ void vecMul(const float* a, const float* b, float* c, int n) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;

        if (idx < n)
            c[idx] = a[idx] * b[idx];

    }

}

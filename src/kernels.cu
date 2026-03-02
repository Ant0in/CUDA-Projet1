
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

    __global__ void vecAddJ(const float* a, const float* b, float* c, int n, int j) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        int stride = blockDim.x * gridDim.x;

        // each thread processes j elements, so we loop over j and compute the corresponding index for each element
        for (int t = 0; t < j; t++) {
            int i = idx + t * stride;
            if (i < n) {
                c[i] = a[i] + b[i];
            }
        }

    }

    __global__ void vecMulJ(const float* a, const float* b, float* c, int n, int j) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        int stride = blockDim.x * gridDim.x;

        // each thread processes j elements, so we loop over j and compute the corresponding index for each element
        for (int t = 0; t < j; t++) {
            int i = idx + t * stride;
            if (i < n) {
                c[i] = a[i] * b[i];
            }
        }

    }

}

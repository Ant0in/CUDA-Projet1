
#include "kernels.cuh"

namespace kernels {

    __global__ void vecAdd(const float* a, const float* b, float* c, int n, int k) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;

        if (idx < n) {

            float v1 = a[idx];
            float v2 = b[idx];

            // perform k additions to increase the computational load
            for (int i = 0; i < k; i++) {
                v1 += v2;
            }

            c[idx] = v1;

        }

    }

    __global__ void vecMul(const float* a, const float* b, float* c, int n, int k) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;

        if (idx < n) {

            float v1 = a[idx];
            float v2 = b[idx];

            // perform k multiplications to increase the computational load
            for (int i = 0; i < k; i++) {
                v1 *= v2;
            }

            c[idx] = v1;

        }

    }

    __global__ void vecAddJ(const float* a, const float* b, float* c, int n, int j, int k) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        int stride = blockDim.x * gridDim.x;

        // each thread processes j elements, so we loop over j and compute the corresponding index for each element
        for (int t = 0; t < j; t++) {
            int i = idx + t * stride;
            if (i < n) {
                float v1 = a[i];
                float v2 = b[i];
                // perform k additions to increase the computational load
                for (int l = 0; l < k; l++) {
                    v1 += v2;
                }
                c[i] = v1;
            }
        }

    }

    __global__ void vecMulJ(const float* a, const float* b, float* c, int n, int j, int k) {

        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        int stride = blockDim.x * gridDim.x;

        // each thread processes j elements, so we loop over j and compute the corresponding index for each element
        for (int t = 0; t < j; t++) {
            int i = idx + t * stride;
            if (i < n) {
                float v1 = a[i];
                float v2 = b[i];
                // perform k multiplications to increase the computational load
                for (int l = 0; l < k; l++) {
                    v1 *= v2;
                }
                c[i] = v1;
            }
        }

    }

}
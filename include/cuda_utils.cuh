
#pragma once

#include <functional>
#include <cuda_runtime.h>

namespace cuda_utils {

    /**
     * @brief Check for CUDA errors and print an error message if any.
     * 
     * @param err The CUDA error code to check
     */
    void checkCudaError(cudaError_t err);

    /**
     * @brief Measure the execution time of a given function.
     * 
     * @param func The function to execute and measure
     * @return The execution time in milliseconds
     */
    float measure(std::function<void()> func);

    /**
     * @brief Print information about the CUDA device being used.
     */
    void printDeviceInfo();

}

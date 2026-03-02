
#include "cuda_utils.cuh"
#include <iostream>

namespace cuda_utils {

    void checkCudaError(cudaError_t err) {

        // if error code is not success, print error message and exit
        if (err != cudaSuccess) {
            std::cerr << "CUDA Error: " << cudaGetErrorString(err) << std::endl;
            exit(EXIT_FAILURE);
        }

    }

    float measure(std::function<void()> func) {

        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);

        // Record the start event, execute the function, and record the stop event
        cudaEventRecord(start);
        func();
        cudaEventRecord(stop);

        cudaEventSynchronize(stop);

        float milliseconds = 0;
        cudaEventElapsedTime(&milliseconds, start, stop);

        cudaEventDestroy(start);
        cudaEventDestroy(stop);

        return milliseconds;

    }

    void printDeviceInfo() {

        int deviceCount;
        checkCudaError(cudaGetDeviceCount(&deviceCount));

        if (deviceCount == 0) {
            std::cout << "No CUDA devices found." << std::endl;
            return;
        }

        // for each device, we print a wall of text with all properties lol
        for (int i = 0; i < deviceCount; ++i) {
            cudaDeviceProp prop;
            checkCudaError(cudaGetDeviceProperties(&prop, i));
            std::cout << "Device " << i << ": " << prop.name << std::endl;
            std::cout << "  Compute capability: " << prop.major << "." << prop.minor << std::endl;
            std::cout << "  Total global memory: " << prop.totalGlobalMem / (1024 * 1024) << " MB" << std::endl;
            std::cout << "  Multiprocessors: " << prop.multiProcessorCount << std::endl;
            std::cout << "  Max threads per block: " << prop.maxThreadsPerBlock << std::endl;
            std::cout << "  Max threads per multiprocessor: " << prop.maxThreadsPerMultiProcessor << std::endl;
            std::cout << "  Warp size: " << prop.warpSize << std::endl;
            std::cout << std::endl;
        }
    }

}

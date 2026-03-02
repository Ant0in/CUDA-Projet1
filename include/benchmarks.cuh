
#pragma once

/**
 * @file benchmarks.cuh
 * @brief Header file for the Benchmark class that runs CUDA benchmarks for vector addition and multiplication.
 * 
 * This class provides methods to execute CUDA kernels for vector addition and multiplication, and to measure their execution time.
 * It uses utility functions from cuda_utils.cuh for error checking and timing.
 */
class Benchmark {

public:

    Benchmark();
    ~Benchmark() = default;

    void runAddition(int n);
    void runMultiplication(int n);

};

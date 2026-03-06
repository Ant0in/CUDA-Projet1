#include "benchmarks.cuh"
#include "cuda_utils.cuh"
#include <iostream>

int main(int argc, char* argv[]) {

    Benchmark bench;

    const int K = 20;   // plus de répétitions = plus stable
    const int J_min = 1;
    const int J_max = 32;

    std::cout << "===== CUDA BENCHMARK START =====" << std::endl;

    // Vector sizes from 2^10 to 2^32 (~4 billion)
    for (int exp = 10; exp <= 30; exp++) {

        size_t n = 1ULL << exp;

        std::cout << "\n---- N = 2^" << exp 
                  << " (" << n << " elements) ----" << std::endl;

        for (int J = J_min; J <= J_max; J *= 2) {

            std::cout << "J = " << J << std::endl;

            bench.runAddition(n, K);
            bench.runAdditionJ(n, J, K);

            bench.runMultiplication(n, K);
            bench.runMultiplicationJ(n, J, K);
        }
    }

    std::cout << "\n===== BENCHMARK END =====" << std::endl;

    return 0;
}
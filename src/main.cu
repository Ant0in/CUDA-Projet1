
#include "benchmarks.cuh"
#include "cuda_utils.cuh"
#include <iostream>


int main(int argc, char* argv[]) {

    Benchmark bench;

    const int K = 10;

    // run benchmarks for vector sizes from 1024 (2^10) to 1 billion (2^30)
    for (int exp = 10; exp <= 30; exp++) {
        
        int n = 1 << exp;

        bench.runAddition(n, K);
        bench.runMultiplication(n, K);

        for (int J = 1; J <= 16; J *= 2) {
            bench.runAdditionJ(n, J, K);
            bench.runMultiplicationJ(n, J, K);
        }

    }

    return 0;

}

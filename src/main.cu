
#include "benchmarks.cuh"
#include "cuda_utils.cuh"


int main(int argc, char* argv[]) {

    Benchmark bench;

    // run benchmarks for vector sizes from 2^9 to 2^25
    for (int exp = 9; exp <= 25; exp++) {
        int n = 1 << exp;

        bench.runAddition(n);
        bench.runMultiplication(n);

    }

    return 0;

}

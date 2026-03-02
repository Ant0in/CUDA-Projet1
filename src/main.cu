
#include "benchmark.cuh"
#include "cuda_utils.cuh"


int main(int argc, char* argv[]) {

    Benchmark bench;

    // run benchmarks for vector sizes from (2^9) to (2^26). 
    for (int exp = 12; exp <= 26; exp++) {
        int n = 1 << exp;

        bench.runAddition(n);
        bench.runMultiplication(n);

    }

    return 0;

}

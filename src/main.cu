
#include "benchmarks.cuh"
#include "cuda_utils.cuh"


int main(int argc, char* argv[]) {

    Benchmark bench;

    const int K = 10;
    const int J = 8;

    // run benchmarks for vector sizes from 1024 (2^10) to 1 billion (2^30)
    for (int exp = 10; exp <= 30; exp++) {
        int n = 1 << exp;

        bench.runAddition(n, K);
        bench.runAdditionJ(n, J, K);
        bench.runMultiplication(n, K);
        bench.runMultiplicationJ(n, J, K);

    }

    return 0;

}

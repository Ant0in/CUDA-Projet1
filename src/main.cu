
#include "benchmarks.cuh"
#include "cuda_utils.cuh"

#include <iostream>
#include <vector>
#include <cmath>
#include <numeric>

/**
 * Checks if the current measurement is stable compared to the history.
 * A measurement is considered stable if it is within a certain percentage (tol) of the average of the history.
 * @param cur The current measurement to check.
 * @param h The history of measurements.
 * @param tol The tolerance for stability.
 * @return True if the measurement is stable, false otherwise.
 */
bool is_stable(float cur, const std::vector<float>& h, float tol = 0.02f) {

    if (h.empty()) return false;
    float avg = std::accumulate(h.begin(), h.end(), 0.0f) / h.size();
    return std::abs(cur - avg) / avg < tol;
}

/*

!! deprecated, used for testing on my 1060, not relevant for the report

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

*/

/**
 * Main function to find optimal parameters for vector addition and multiplication benchmarks.
 * It first determines the optimal vector size (N) by running multiplication benchmarks and checking for stability
 * then determines the optimal number of iterations (J) for the benchmarks. Finally, it runs the roofline benchmarks with the optimal parameters.
 * @param argc The number of command-line arguments.
 * @param argv The array of command-line arguments.
 * @return 0 on successful execution.
 */
int main(int argc, char* argv[]) {

    Benchmark bench;

    const int K = 10;
    size_t opt_N = 1ULL << 20;
    int opt_J = 1;
    std::vector<float> hist;

    std::cout << "===== Optimal N =====" << std::endl;

    for (int e = 20; e <= 30; e++) {

        size_t n = 1ULL << e;
        float cur = bench.runMultiplicationJ(n, 1, K);
        if (hist.size() >= 3 && is_stable(cur, hist)) {
            opt_N = 1ULL << (e - 3); // prend le 1er point du plateau
            std::cout << ">>> N: 2^" << e-3 << std::endl;
            break;
        }

        if (hist.size() >= 3) hist.erase(hist.begin());
        hist.push_back(cur);
        opt_N = n; 

    }

    std::cout << "\n===== Optimal J =====" << std::endl;

    hist.clear();
    float best = 0;

    for (int j : {1, 2, 4, 8, 16, 32}) {

        float cur = bench.runMultiplicationJ(opt_N, j, K);
        if (hist.size() >= 2 && is_stable(cur, hist)) {
            std::cout << ">>> J: " << opt_J << std::endl;
            break;
        }

        if (cur > best) { best = cur; opt_J = j; }
        if (hist.size() >= 2) hist.erase(hist.begin());
        hist.push_back(cur);

    }

    std::cout << "\n===== Roofline (N=2^" << (int)log2(opt_N) << ", J=" << opt_J << ") =====" << std::endl;

    cudaDeviceSynchronize();

    for (int k = 1; k <= 2048; k = (k < 16) ? k + 1 : k * 2) {
        bench.runAdditionJ(opt_N, opt_J, k);
        bench.runMultiplicationJ(opt_N, opt_J, k);
    }

    return 0;

}

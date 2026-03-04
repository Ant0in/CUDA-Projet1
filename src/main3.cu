#include "benchmarks.cuh"
#include "cuda_utils.cuh"
#include <iostream>
#include <vector>
#include <cmath>
#include <numeric>

bool is_stable(float cur, const std::vector<float>& h, float tol = 0.02f) {
    if (h.empty()) return false;
    float avg = std::accumulate(h.begin(), h.end(), 0.0f) / h.size();
    return std::abs(cur - avg) / avg < tol;
}

int main(int argc, char* argv[]) {
    Benchmark bench;
    const int K_test = 10;
    size_t opt_N = 1ULL << 20;
    int opt_J = 1;
    std::vector<float> hist;

    std::cout << "===== N OPTI =====" << std::endl;
    for (int e = 20; e <= 30; e++) {
        size_t n = 1ULL << e;
        float cur = bench.runMultiplicationJ(n, 1, K_test);
        
        if (hist.size() >= 3 && is_stable(cur, hist)) {
            opt_N = 1ULL << (e - 3); // prend le 1er point du plateau
            std::cout << ">>> N: 2^" << e-3 << std::endl;
            break;
        }
        if (hist.size() >= 3) hist.erase(hist.begin());
        hist.push_back(cur);
        opt_N = n; 
    }

    std::cout << "\n===== J OPTI =====" << std::endl;
    hist.clear();
    float best = 0;

    for (int j : {1, 2, 4, 8, 16, 32}) {
        float cur = bench.runMultiplicationJ(opt_N, j, K_test);
        if (hist.size() >= 2 && is_stable(cur, hist)) {
            std::cout << ">>> J: " << opt_J << std::endl;
            break;
        }
        if (cur > best) { best = cur; opt_J = j; }
        if (hist.size() >= 2) hist.erase(hist.begin());
        hist.push_back(cur);
    }

    std::cout << "\n===== ROOFLINE (N=2^" << (int)log2(opt_N) << ", J=" << opt_J << ") =====" << std::endl;
    cudaDeviceSynchronize();

    for (int k = 1; k <= 2048; k = (k < 16) ? k + 1 : k * 2) {
        bench.runAdditionJ(opt_N, opt_J, k);
        bench.runMultiplicationJ(opt_N, opt_J, k);
    }

    return 0;
}
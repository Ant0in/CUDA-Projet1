#include "benchmarks.cuh"
#include <iostream>
#include <vector>

int main() {
    Benchmark bench;
    const int K = 1; // On garde K petit pour être sûr d'être Memory-Bound
    
    std::cout << "===== SCAN AUTOMATIQUE : PERFORMANCE vs TAILLE N =====" << std::endl;
    std::cout << "Objectif : Convergence vers le max (Memory-Bound)" << std::endl;

    // On balaye de 2^10 (1K) à 2^28 (256M)
    // On s'arrête si ça crash ou si on sature
    for (int exp = 10; exp <= 28; exp++) {
        size_t n = 1ULL << exp;
        
        // On lance les deux types d'opérations
        // runAddition retourne les GFLOPS calculés
        float g_add = bench.runAddition(n, K);
        float g_mul = bench.runMultiplication(n, K);

        // Si tu vois que les GFLOPS ne bougent plus entre 2^24 et 2^25,
        // c'est que tu as atteint la bande passante max de ta 4070.
    }

    return 0;
}
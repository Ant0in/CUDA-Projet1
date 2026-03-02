#pragma once

#include <cuda_runtime.h>


__global__ void vecAdd(const float* a, const float* b, float* c, int n);

void launchVecAdd(const float* a, const float* b, float* c, int n);

int main(int argc, char* argv[]);

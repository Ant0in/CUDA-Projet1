<!-- markdownlint-disable MD033 MD041 MD007 -->

<!-- pretty badges -->
<div align="center">
  <img src="https://img.shields.io/badge/Language-Cuda-red" alt="Language Badge"/>
  <img src="https://img.shields.io/badge/Version-0.0.1-blue" alt="Version Badge">
  <img src="https://img.shields.io/badge/License-MIT-dark_green.svg" alt="License Badge"/>
  <img src="https://img.shields.io/badge/School-ULB-yellow" alt="School Badge"/>
</div>

# ⚡ CUDA Benchmark Mini-Project

This project is part of the **INFO-H503 course (ULB)**. It implements simple vector **addition and multiplication kernels** in `CUDA` and benchmarks their performance on your GPU.

The goal is to study **memory vs compute-bound operations** and visualize performance trends (GFLOPS, bandwidth) with different array sizes and computational intensity (`j` loops).

```sh
Array A ──┐
├─► GPU threads ──► Vector Op ──► Result C  # Kernel Workflow
Array B ──┘
```

## 📜 Features

- **CUDA kernels** for float vector addition and multiplication.
- Optional **J-sweep kernels** where each thread processes multiple elements.
- Automatic **benchmarking** over a range of array sizes.
- Computes **execution time**, **GFLOPS**, and **bandwidth**.
- Prints **GPU device info** using CUDA runtime API.

## ⚙️ Installation

1. Clone the repository:

    ```sh
    git clone git@github.com:Ant0in/CUDA-Projet1.git
    cd CUDA-Projet1
    ```

2. Make sure you have **Cuda installed** and a **Cuda-capable GPU**. Cuda can be installed using `pacman` or `apt`:

    ```sh
    nvidia-smi  # check if you have a cuda-capable gpu
    sudo pacman -Syu nvidia nvidia-utils nvidia-settings
    sudo pacman -S cuda
    ```

3. Build using the provided `Makefile`:

    ```sh
    make  # you can use the clean rule to remove build files
    ```

Alternatively, you can compile it by hand using `nvcc` if you are on **Windows**.

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

## 🙏 Acknowledgements

This project was developed for the **`GPU Computing`** course **`INFO—H503`**. Special thanks to `Bonatto Daniele (ULB)` and `Soetens Eline (ULB)` for their guidance and support.

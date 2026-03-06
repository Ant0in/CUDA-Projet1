Device 0: NVIDIA GeForce RTX 4070
  Compute capability: 8.9
  Total global memory: 12281 MB
  Multiprocessors: 46
  Max threads per block: 1024
  Max threads per multiprocessor: 1536
  Warp size: 32

===== N OPTI =====
MultiplicationJ - Size: 1048576, J: 1, Time: 0.0306016 ms, GFLOPS: 342.654, Bandwidth: 411.185 GB/s, k :10
MultiplicationJ - Size: 2097152, J: 1, Time: 0.0178912 ms, GFLOPS: 1172.17, Bandwidth: 1406.6 GB/s, k :10
MultiplicationJ - Size: 4194304, J: 1, Time: 0.103834 ms, GFLOPS: 403.945, Bandwidth: 484.734 GB/s, k :10
MultiplicationJ - Size: 8388608, J: 1, Time: 0.227123 ms, GFLOPS: 369.342, Bandwidth: 443.21 GB/s, k :10
MultiplicationJ - Size: 16777216, J: 1, Time: 0.540336 ms, GFLOPS: 310.496, Bandwidth: 372.595 GB/s, k :10
MultiplicationJ - Size: 33554432, J: 1, Time: 1.24539 ms, GFLOPS: 269.429, Bandwidth: 323.315 GB/s, k :10
MultiplicationJ - Size: 67108864, J: 1, Time: 2.07483 ms, GFLOPS: 323.442, Bandwidth: 388.131 GB/s, k :10
MultiplicationJ - Size: 134217728, J: 1, Time: 3.78959 ms, GFLOPS: 354.174, Bandwidth: 425.009 GB/s, k :10
MultiplicationJ - Size: 268435456, J: 1, Time: 9.17688 ms, GFLOPS: 292.513, Bandwidth: 351.015 GB/s, k :10
MultiplicationJ - Size: 536870912, J: 1, Time: 15.3335 ms, GFLOPS: 350.13, Bandwidth: 420.156 GB/s, k :10
MultiplicationJ - Size: 1073741824, J: 1, Time: 224.313 ms, GFLOPS: 47.868, Bandwidth: 57.4416 GB/s, k :10

===== J OPTI =====
MultiplicationJ - Size: 1073741824, J: 1, Time: 225.225 ms, GFLOPS: 47.6742, Bandwidth: 57.2091 GB/s, k :10
MultiplicationJ - Size: 1073741824, J: 2, Time: 214.491 ms, GFLOPS: 50.0599, Bandwidth: 60.0719 GB/s, k :10
MultiplicationJ - Size: 1073741824, J: 4, Time: 214.246 ms, GFLOPS: 50.1173, Bandwidth: 60.1408 GB/s, k :10
MultiplicationJ - Size: 1073741824, J: 8, Time: 220.592 ms, GFLOPS: 48.6755, Bandwidth: 58.4106 GB/s, k :10
MultiplicationJ - Size: 1073741824, J: 16, Time: 219.688 ms, GFLOPS: 48.8759, Bandwidth: 58.651 GB/s, k :10
>>> J: 4

===== ROOFLINE (N=2^30, J=4) =====
AdditionJ - Size: 1073741824, J: 4, Time: 221.254 ms, GFLOPS: 4.85299, Bandwidth: 58.2359 GB/s, K: 1
MultiplicationJ - Size: 1073741824, J: 4, Time: 213.114 ms, GFLOPS: 5.03834, Bandwidth: 60.4601 GB/s, k :1
AdditionJ - Size: 1073741824, J: 4, Time: 212.766 ms, GFLOPS: 10.0932, Bandwidth: 60.559 GB/s, K: 2
MultiplicationJ - Size: 1073741824, J: 4, Time: 212.726 ms, GFLOPS: 10.0951, Bandwidth: 60.5704 GB/s, k :2
AdditionJ - Size: 1073741824, J: 4, Time: 214.863 ms, GFLOPS: 14.992, Bandwidth: 59.968 GB/s, K: 3
MultiplicationJ - Size: 1073741824, J: 4, Time: 214.88 ms, GFLOPS: 14.9908, Bandwidth: 59.9632 GB/s, k :3
AdditionJ - Size: 1073741824, J: 4, Time: 215.467 ms, GFLOPS: 19.9333, Bandwidth: 59.7998 GB/s, K: 4
MultiplicationJ - Size: 1073741824, J: 4, Time: 212.652 ms, GFLOPS: 20.1972, Bandwidth: 60.5915 GB/s, k :4
AdditionJ - Size: 1073741824, J: 4, Time: 220.794 ms, GFLOPS: 24.3155, Bandwidth: 58.3572 GB/s, K: 5
MultiplicationJ - Size: 1073741824, J: 4, Time: 213.701 ms, GFLOPS: 25.1225, Bandwidth: 60.2941 GB/s, k :5
AdditionJ - Size: 1073741824, J: 4, Time: 227.217 ms, GFLOPS: 28.3538, Bandwidth: 56.7076 GB/s, K: 6
MultiplicationJ - Size: 1073741824, J: 4, Time: 229.177 ms, GFLOPS: 28.1112, Bandwidth: 56.2225 GB/s, k :6
AdditionJ - Size: 1073741824, J: 4, Time: 225.817 ms, GFLOPS: 33.2844, Bandwidth: 57.059 GB/s, K: 7
MultiplicationJ - Size: 1073741824, J: 4, Time: 228.301 ms, GFLOPS: 32.9223, Bandwidth: 56.4382 GB/s, k :7
AdditionJ - Size: 1073741824, J: 4, Time: 220.974 ms, GFLOPS: 38.8731, Bandwidth: 58.3097 GB/s, K: 8
MultiplicationJ - Size: 1073741824, J: 4, Time: 227.234 ms, GFLOPS: 37.8022, Bandwidth: 56.7033 GB/s, k :8
AdditionJ - Size: 1073741824, J: 4, Time: 225.16 ms, GFLOPS: 42.9192, Bandwidth: 57.2255 GB/s, K: 9
MultiplicationJ - Size: 1073741824, J: 4, Time: 221.901 ms, GFLOPS: 43.5495, Bandwidth: 58.066 GB/s, k :9
AdditionJ - Size: 1073741824, J: 4, Time: 220.324 ms, GFLOPS: 48.7347, Bandwidth: 58.4817 GB/s, K: 10
MultiplicationJ - Size: 1073741824, J: 4, Time: 221.841 ms, GFLOPS: 48.4015, Bandwidth: 58.0818 GB/s, k :10
AdditionJ - Size: 1073741824, J: 4, Time: 223.577 ms, GFLOPS: 52.8283, Bandwidth: 57.6308 GB/s, K: 11
MultiplicationJ - Size: 1073741824, J: 4, Time: 220.826 ms, GFLOPS: 53.4862, Bandwidth: 58.3486 GB/s, k :11
AdditionJ - Size: 1073741824, J: 4, Time: 225.461 ms, GFLOPS: 57.1491, Bandwidth: 57.1491 GB/s, K: 12
MultiplicationJ - Size: 1073741824, J: 4, Time: 223.41 ms, GFLOPS: 57.6738, Bandwidth: 57.6738 GB/s, k :12
AdditionJ - Size: 1073741824, J: 4, Time: 223.237 ms, GFLOPS: 62.5282, Bandwidth: 57.7184 GB/s, K: 13
MultiplicationJ - Size: 1073741824, J: 4, Time: 222.187 ms, GFLOPS: 62.8239, Bandwidth: 57.9913 GB/s, k :13
AdditionJ - Size: 1073741824, J: 4, Time: 226.288 ms, GFLOPS: 66.4303, Bandwidth: 56.9403 GB/s, K: 14
MultiplicationJ - Size: 1073741824, J: 4, Time: 222.511 ms, GFLOPS: 67.5578, Bandwidth: 57.9067 GB/s, k :14
AdditionJ - Size: 1073741824, J: 4, Time: 226.581 ms, GFLOPS: 71.0832, Bandwidth: 56.8666 GB/s, K: 15
MultiplicationJ - Size: 1073741824, J: 4, Time: 219.713 ms, GFLOPS: 73.3054, Bandwidth: 58.6443 GB/s, k :15
AdditionJ - Size: 1073741824, J: 4, Time: 228.77 ms, GFLOPS: 75.0966, Bandwidth: 56.3224 GB/s, K: 16
MultiplicationJ - Size: 1073741824, J: 4, Time: 225.304 ms, GFLOPS: 76.2519, Bandwidth: 57.1889 GB/s, k :16
AdditionJ - Size: 1073741824, J: 4, Time: 222.877 ms, GFLOPS: 154.164, Bandwidth: 57.8117 GB/s, K: 32
MultiplicationJ - Size: 1073741824, J: 4, Time: 224.212 ms, GFLOPS: 153.247, Bandwidth: 57.4675 GB/s, k :32
AdditionJ - Size: 1073741824, J: 4, Time: 283.469 ms, GFLOPS: 242.423, Bandwidth: 45.4544 GB/s, K: 64
MultiplicationJ - Size: 1073741824, J: 4, Time: 283.735 ms, GFLOPS: 242.196, Bandwidth: 45.4117 GB/s, k :64
AdditionJ - Size: 1073741824, J: 4, Time: 308.86 ms, GFLOPS: 444.988, Bandwidth: 41.7176 GB/s, K: 128
MultiplicationJ - Size: 1073741824, J: 4, Time: 287.94 ms, GFLOPS: 477.319, Bandwidth: 44.7486 GB/s, k :128
AdditionJ - Size: 1073741824, J: 4, Time: 349.241 ms, GFLOPS: 787.071, Bandwidth: 36.894 GB/s, K: 256
MultiplicationJ - Size: 1073741824, J: 4, Time: 283.577 ms, GFLOPS: 969.324, Bandwidth: 45.4371 GB/s, k :256
AdditionJ - Size: 1073741824, J: 4, Time: 290.204 ms, GFLOPS: 1894.37, Bandwidth: 44.3994 GB/s, K: 512
MultiplicationJ - Size: 1073741824, J: 4, Time: 222.159 ms, GFLOPS: 2474.61, Bandwidth: 57.9986 GB/s, k :512
AdditionJ - Size: 1073741824, J: 4, Time: 226.29 ms, GFLOPS: 4858.87, Bandwidth: 56.9399 GB/s, K: 1024
MultiplicationJ - Size: 1073741824, J: 4, Time: 225.514 ms, GFLOPS: 4875.58, Bandwidth: 57.1357 GB/s, k :1024
AdditionJ - Size: 1073741824, J: 4, Time: 267.252 ms, GFLOPS: 8228.27, Bandwidth: 48.2125 GB/s, K: 2048
MultiplicationJ - Size: 1073741824, J: 4, Time: 267.11 ms, GFLOPS: 8232.64, Bandwidth: 48.2381 GB/s, k :2048

# Makefile for our CUDA project
# it is a small sample that compiles all .cu files in src/ and links them into an executable named main
# dont use that if you are on windows, im just the wsl guy

CUDA_PATH ?= /usr/local/cuda
NVCC      := nvcc

SRC_DIR   := src
INC_DIR   := include
BUILD_DIR := build

TARGET    := main

SRCS := $(wildcard $(SRC_DIR)/*.cu)  # find all .cu files in src/

OBJS := $(patsubst $(SRC_DIR)/%.cu,$(BUILD_DIR)/%.o,$(SRCS))  # create /build/%.o for each .cu file

CXXFLAGS := -I$(INC_DIR)
NVFLAGS  := -std=c++17 -arch=sm_61  # here please adjust the arch if needed; i have a GTX1060, so sm_61 is fine for me

all: $(TARGET)

$(TARGET): $(OBJS)
	@$(NVCC) $(NVFLAGS) $^ -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cu
	@mkdir -p $(BUILD_DIR)
	@$(NVCC) $(NVFLAGS) $(CXXFLAGS) -c $< -o $@

clean:
	@rm -rf $(BUILD_DIR) $(TARGET)

.PHONY: all clean
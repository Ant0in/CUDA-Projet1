# --- Configuration ---
CUDA_PATH ?= /usr/local/cuda
NVCC      := nvcc

SRC_DIR   := src
INC_DIR   := include
BUILD_DIR := build
LOG_DIR   := logs
RES_DIR   := res
GRAPH_DIR := res/graph

# RTX 4070 = compute capability 8.9 (Ada Lovelace)
NVFLAGS   := -std=c++17 -arch=sm_89
CXXFLAGS  := -I$(INC_DIR)

# --- Fichiers ---
# On compile tous les .cu du dossier src SAUF main.cu (benchmarks, kernels, utils)
SRCS      := $(filter-out $(SRC_DIR)/main.cu,$(wildcard $(SRC_DIR)/*.cu))
OBJS      := $(patsubst $(SRC_DIR)/%.cu,$(BUILD_DIR)/%.o,$(SRCS))

# Tes 3 programmes principaux
TARGETS   := main1 main2 main3

# --- Règles de compilation ---

all: $(TARGETS)

# Règle générique pour compiler main1, main2, main3
main%: main%.cu $(OBJS)
	$(NVCC) $(NVFLAGS) $(CXXFLAGS) $^ -o $@

# Compilation des objets dans src/
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cu
	@mkdir -p $(BUILD_DIR)
	$(NVCC) $(NVFLAGS) $(CXXFLAGS) -c $< -o $@

# --- Pipeline d'exécution automatique ---

# Lance la chaîne complète pour les 3 mains
run_all: run1 run2 run3
	@echo ">>> Tous les benchmarks et graphiques sont terminés !"

run1: main1
	@mkdir -p $(LOG_DIR) $(RES_DIR) $(GRAPH_DIR)
	@echo "--- Exécution Main 1 ---"
	./main1 > $(LOG_DIR)/results1.md
	@echo "--- Conversion CSV ---"
	python3 res/scripts/converter1.py $(LOG_DIR)/results1.md $(RES_DIR)/scan_results1.csv
	@echo "--- Génération Graphique ---"
	python3 res/scripts/Ex1Graph.py $(RES_DIR)/scan_results1.csv

run2: main2
	@mkdir -p $(LOG_DIR) $(RES_DIR) $(GRAPH_DIR)
	@echo "--- Exécution Main 2 ---"
	./main2 > $(LOG_DIR)/results2.md
	@echo "--- Conversion CSV ---"
	python3 res/scripts/converter2.py $(LOG_DIR)/results2.md $(RES_DIR)/csv2.csv
	@echo "--- Génération Graphique ---"
	python3 res/scripts/Ex2Graph.py $(RES_DIR)/csv2.csv

run3: main3
	@mkdir -p $(LOG_DIR) $(RES_DIR) $(GRAPH_DIR)
	@echo "--- Exécution Main 3 ---"
	./main3 > $(LOG_DIR)/results3.md
	@echo "--- Conversion CSV ---"
	python3 res/scripts/converter3.py $(LOG_DIR)/results3.md $(RES_DIR)/roofline_4070.csv
	@echo "--- Génération Graphique ---"
	python3 res/scripts/Ex3Graph.py $(RES_DIR)/roofline_4070.csv

# --- Nettoyage ---
clean:
	rm -rf $(BUILD_DIR) $(TARGETS) $(LOG_DIR) $(GRAPH_DIR)
	rm -f $(RES_DIR)/*.csv $(RES_DIR)/*.md

.PHONY: all clean run_all run1 run2 run3
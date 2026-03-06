import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings

warnings.filterwarnings('ignore', category=FutureWarning)

# Chemins
output_dir = "res/graph"
if not os.path.exists(output_dir): os.makedirs(output_dir)

import sys
if len(sys.argv) != 2:
    print("Usage: python3 Ex1Graph.py <input.csv>")
    exit(1)
csvfile = sys.argv[1]
df = pd.read_csv(csvfile)

# Correction des noms de colonnes pour matcher ton CSV
# On remplace 'Memory Performance' par 'Bandwidth_GBs'
col_gflops = 'GFLOPS'
col_bw = 'Bandwidth_GBs'

# Nettoyage si besoin (cas des virgules à la place des points)
for col in [col_gflops, col_bw]:
    if df[col].dtype == 'object':
        df[col] = df[col].str.replace(',', '.').astype(float)

sns.set_theme(style="whitegrid")

# --- GRAPH 1 : GFLOPS vs N ---
plt.figure(figsize=(10, 6))
sns.lineplot(data=df, x='N', y=col_gflops, hue='Type', marker='o')
plt.xscale('log'); plt.yscale('log')
plt.title('Performance Calcul (GFLOPS) - Saturation')
plt.savefig(os.path.join(output_dir, 'gflops.png'))

# --- GRAPH 2 : BANDE PASSANTE vs N ---
plt.figure(figsize=(10, 6))
sns.lineplot(data=df, x='N', y=col_bw, hue='Type', marker='o', palette='viridis')
plt.xscale('log') # Pas besoin de log sur Y ici pour bien voir le plateau
plt.ylabel('Bande Passante (GB/s)')
plt.title('Bande Passante (GB/s) - Convergence vers le Max')
plt.savefig(os.path.join(output_dir, 'memory.png'))

# --- GRAPH 3 : SCATTER GFLOPS vs BW ---
plt.figure(figsize=(10, 6))
sns.scatterplot(data=df, x=col_bw, y=col_gflops, hue='Type', s=100, alpha=0.7)
plt.title('Efficacité : GFLOPS vs Bande Passante')
plt.xlabel('Bande Passante (GB/s)')
plt.ylabel('Performance (GFLOPS)')

plt.tight_layout()
plt.savefig(os.path.join(output_dir, 'scatter_performance.png'))

print(f"Graphiques dans {output_dir}")
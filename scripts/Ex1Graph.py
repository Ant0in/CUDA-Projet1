import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import warnings

warnings.filterwarnings('ignore', category=FutureWarning)

downloads_path = os.path.join(os.path.expanduser("~"), "Downloads")
output_dir = os.path.join(downloads_path, "results_gpu")
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

DATA_PATH = os.path.join(downloads_path, "performance_basic.csv")
df = pd.read_csv(DATA_PATH, sep=';')

for col in ['GFLOPS', 'Memory Performance']:
    if df[col].dtype == 'object':
        df[col] = df[col].str.replace(',', '.').astype(float)

sns.set_theme(style="whitegrid")

plt.figure(figsize=(10, 6))
ax1 = sns.lineplot(data=df, x='N', y='GFLOPS', hue='Type', marker='o')
ax1.set_xscale('log')
ax1.set_yscale('log')
plt.title('Performance Calcul (GFLOPS) - Log-Log')
plt.savefig(os.path.join(output_dir, 'gflops.png'))

plt.figure(figsize=(10, 6))
ax2 = sns.lineplot(data=df, x='N', y='Memory Performance', hue='Type', marker='o', palette='viridis')
ax2.set_xscale('log')
ax2.set_yscale('log')
plt.title('Bande Passante (GB/s) - Log-Log')
plt.savefig(os.path.join(output_dir, 'memory.png'))

plt.figure(figsize=(10, 6))
ax3 = sns.scatterplot(data=df, x='Memory Performance', y='GFLOPS', hue='Type', s=50, alpha=0.6)

ax3.set_xscale('log')
ax3.set_yscale('log')

plt.title('Analyse d\'Efficacité : GFLOPS vs Bande Passante')
plt.xlabel('Bande Passante (GB/s) [Log]')
plt.ylabel('Performance (GFLOPS) [Log]')

plt.tight_layout()
plt.savefig(os.path.join(output_dir, 'scatter_performance.png'))

print(f"Terminé ! Les 3 graphiques sont dans : {output_dir}")
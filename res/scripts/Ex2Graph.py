import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings

warnings.filterwarnings('ignore', category=FutureWarning)

# --- CONFIGURATION DES CHEMINS ---
base_dir = os.path.dirname(os.path.abspath(__file__))
res_dir = os.path.join(base_dir)
output_dir = os.path.join(base_dir, "..", "res", "graph")

if not os.path.exists(output_dir):
    os.makedirs(output_dir)


import sys
if len(sys.argv) != 2:
    print("Usage: python3 Ex2Graph.py <input.csv>")
    exit(1)
input_file = sys.argv[1]
if not os.path.exists(input_file):
    print(f"Introuvable: {input_file}")
    exit()

# Lecture du CSV
df = pd.read_csv(input_file, sep=';')

# --- DEBUG : Affiche les types trouvés dans le CSV ---
print(f"Types: {df['Type'].unique()}")
print(f"Total: {len(df)} lignes")

for col in ['GFLOPS', 'Memory Performance']:
    df[col] = df[col].astype(str).str.replace(',', '.')
    df[col] = pd.to_numeric(df[col], errors='coerce')

sns.set_theme(style="white")

def create_heatmap(df_type, metric, title, filename):
    # On filtre les données
    subset = df[df['Type'] == df_type].copy()
    
    if subset.empty:
        print(f"Pas de données {df_type}")
        return

    print(f"Heatmap {df_type} ({len(subset)} pts)")
    
    # Création de la table pivot
    pivot_table = subset.pivot_table(index='N', columns='J', values=metric, aggfunc='mean')
    
    plt.figure(figsize=(12, 8))
    sns.heatmap(pivot_table, annot=True, fmt=".2f", cmap="YlGnBu", cbar_kws={'label': metric})
    
    plt.title(f'Heatmap {df_type} : {title}')
    plt.xlabel('Facteur J (Work per Thread)')
    plt.ylabel('Taille du tableau N')
    
    plt.tight_layout()
    save_path = os.path.join(output_dir, filename)
    plt.savefig(save_path)
    plt.close()
    print(f"Image {save_path}")

# Lancement
create_heatmap('AdditionJ', 'GFLOPS', 'Performance Calcul', 'heatmap_add_gflops.png')
create_heatmap('MultiplicationJ', 'GFLOPS', 'Performance Calcul', 'heatmap_mul_gflops.png')

print("OK")
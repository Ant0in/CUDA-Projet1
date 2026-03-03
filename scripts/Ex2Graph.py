import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings

warnings.filterwarnings('ignore', category=FutureWarning)

# --- CONFIGURATION DES CHEMINS ---
base_dir = os.path.dirname(os.path.abspath(__file__))
res_dir = os.path.join(base_dir, "res")
output_dir = os.path.join(res_dir, "results_heatmaps")

if not os.path.exists(output_dir):
    os.makedirs(output_dir)
    print(f"Dossier créé : {output_dir}")

input_file = os.path.join(res_dir, "performance_j_multi.csv")

if not os.path.exists(input_file):
    print(f"ERREUR : Le fichier '{input_file}' est introuvable.")
    exit()

# Lecture du CSV
df = pd.read_csv(input_file, sep=';')

# --- DEBUG : Affiche les types trouvés dans le CSV ---
print("Types trouvés dans le CSV :", df['Type'].unique())
print(f"Nombre total de lignes : {len(df)}")

for col in ['GFLOPS', 'Memory Performance']:
    df[col] = df[col].astype(str).str.replace(',', '.')
    df[col] = pd.to_numeric(df[col], errors='coerce')

sns.set_theme(style="white")

def create_heatmap(df_type, metric, title, filename):
    # On filtre les données
    subset = df[df['Type'] == df_type].copy()
    
    if subset.empty:
        print(f"ATTENTION : Aucune donnée trouvée pour le type '{df_type}'.")
        return

    print(f"Génération de la heatmap pour {df_type} ({len(subset)} points)...")
    
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
    print(f"SUCCÈS : Image sauvegardée dans {save_path}")

# Lancement
create_heatmap('AdditionJ', 'GFLOPS', 'Performance Calcul', 'heatmap_add_gflops.png')
create_heatmap('MultiplicationJ', 'GFLOPS', 'Performance Calcul', 'heatmap_mul_gflops.png')

print("\nScript terminé.")
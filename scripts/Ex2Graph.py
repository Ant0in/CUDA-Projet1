import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings

warnings.filterwarnings('ignore', category=FutureWarning)
base_dir = os.path.dirname(os.path.abspath(__file__))
res_dir = os.path.join(base_dir, "res")
output_dir = os.path.join(res_dir, "results_heatmaps")

if not os.path.exists(output_dir):
    os.makedirs(output_dir)
    print(f"DoMis dans le dossier {output_dir}")
#f au cas ou caractères spéciaux dans le chemin
input_file = os.path.join(res_dir, "performance_j_multi.csv")

if not os.path.exists(input_file):
    print(f"Fichier '{input_file}' est introuvable.")
    exit()
df = pd.read_csv(input_file, sep=';')

print(f"nombre de ligne: {len(df)}")

for col in ['GFLOPS', 'Memory Performance']:
    df[col] = df[col].astype(str).str.replace(',', '.')
    df[col] = pd.to_numeric(df[col], errors='coerce')
sns.set_theme(style="white")

def create_heatmap(df_type, metric, title, filename):
    subset = df[df['Type'] == df_type].copy()
    if subset.empty:
        print(f"pas de donnée trouvé pour tell classe'{df_type}'.")
        return
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
    print(f"sauvegardée dans {save_path}")
create_heatmap('AdditionJ', 'GFLOPS', 'Performance Calcul', 'heatmap_add_gflops.png')
create_heatmap('MultiplicationJ', 'GFLOPS', 'Performance Calcul', 'heatmap_mul_gflops.png')

print("\nScript terminé.")
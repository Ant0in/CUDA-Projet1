import pandas as pd
import matplotlib.pyplot as plt

def plot(csv):
    try:
        df = pd.read_csv(csv).sort_values('Intensity')
    except: return print("Fichier introuvable.")

    plt.figure(figsize=(10, 6))
    for t in df['Type'].unique():
        d = df[df['Type'] == t]
        plt.plot(d['Intensity'], d['GFLOPS'], 'o-', label=t)

    plt.xscale('log'); plt.yscale('log')
    plt.xlabel('Intensité (FLOPs/Byte)'); plt.ylabel('GFLOPS')
    plt.title('Roofline RTX 4070')
    plt.grid(True, which="both", alpha=0.3)
    plt.legend(); plt.savefig("res/graph/roofline.png")
    print("Roofline OK")

import sys
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 Ex3Graph.py <input.csv>")
        exit(1)
    plot(sys.argv[1])
import re, csv, os

def parse_scan(filepath):
    if not os.path.exists(filepath): return print(f"Fichier {filepath} introuvable.")
    
    results = []
    # Regex pour choper : Type, Size, GFLOPS, Bandwidth
    # Marche pour Addition et Multiplication
    reg = re.compile(r"(?P<t>Addition|Multiplication).*?Size:\s*(?P<n>\d+).*?GFLOPS:\s*(?P<g>[\d.]+).*?Bandwidth:\s*(?P<bw>[\d.]+)", re.I)

    with open(filepath, 'r') as f:
        for line in f:
            m = reg.search(line)
            if m:
                results.append({
                    "Type": m.group("t"),
                    "N": int(m.group("n")),
                    "Log2_N": int(len(bin(int(m.group("n")))) - 3), # pour avoir l'exposant 2^x
                    "GFLOPS": float(m.group("g")),
                    "Bandwidth_GBs": float(m.group("bw"))
                })
    return results

import sys
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 converter1.py <input.md> <output.csv>")
        exit(1)
    infile, outfile = sys.argv[1], sys.argv[2]
    data = parse_scan(infile)
    if data:
        with open(outfile, 'w', newline='') as f:
            w = csv.DictWriter(f, fieldnames=data[0].keys())
            w.writeheader()
            w.writerows(data)
        print(f"{len(data)} lignes -> {outfile}")
    else:
        print("Pas de données")
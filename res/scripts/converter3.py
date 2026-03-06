import re, csv, os

def parse(path):
    if not os.path.exists(path): return []
    res, n, j, go = [], 33554432, 2, False
    # Regex flexible pour chopper type, gflops et k (peu importe la casse)
    reg = re.compile(r"(?P<t>Addition|Multiplication)J.*?GFLOPS:\s*(?P<g>[\d.]+).*?[Kk]\s*:\s*(?P<k>\d+)", re.I)

    with open(path, 'r') as f:
        for line in f:
            if "ROOFLINE" in line: go = True; continue
            if go:
                m = reg.search(line)
                if m:
                    k = int(m.group("k"))
                    type_short = "Add" if "Addition" in m.group("t") else "Mul"
                    res.append({
                        "N": n, "J": j, "Type": type_short, "K": k,
                        "GFLOPS": float(m.group("g")),
                        "Intensity": k / 4.0
                    })
    return res

import sys
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 converter3.py <input.md> <output.csv>")
        exit(1)
    infile, outfile = sys.argv[1], sys.argv[2]
    data = parse(infile)
    if data:
        with open(outfile, 'w', newline='') as f:
            w = csv.DictWriter(f, fieldnames=data[0].keys())
            w.writeheader()
            w.writerows(data)
        print(f"{len(data)} pts")
    else:
        print("Pas de données")
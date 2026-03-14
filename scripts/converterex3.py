import re, csv, os

def parse(path):
    """
    parse le fichier md du 3 ieme test pour en faire un csv. le md est le mem  qu'avant mais le csv doit etre mis dans un autre format
    :param path: le chemin vers le fichier md
    return: none, extrait tout dans roofline_4070.csv"""
    if not os.path.exists(path): return []
    res, n, j, go = [], 4194304, 2, False
    reg = re.compile(r"(?P<t>Add|Mul).*?GFLOPS:\s*(?P<g>[\d.]+).*?[Kk]\s*:\s*(?P<k>\d+)", re.I)

    with open(path, 'r') as f:
        for line in f:
            if "ETAPE 3" in line: go = True; continue
            if go:
                m = reg.search(line)
                if m:
                    k = int(m.group("k"))
                    res.append({
                        "N": n, "J": j, "Type": m.group("t"), "K": k,
                        "GFLOPS": float(m.group("g")),
                        "Intensity": k / 4.0
                    })
    return res

data = parse("4070_4.md")
if data:
    with open("roofline_4070.csv", 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=data[0].keys())
        w.writeheader()
        w.writerows(data)
    print(f"Done: {len(data)} pts.")
else:
    print("Rien trouvé.")
import re
import csv

def transform_md_to_csv(input_filename, output_filename):
    n_pattern = re.compile(r'---- N = 2\^(\d+) \((\d+) elements\) ----')
    j_pattern = re.compile(r'J = (\d+)')
    data_pattern = re.compile(r'(\w+)\s+-\s+Size: (\d+).+?GFLOPS: ([\d\.]+).+?Bandwidth: ([\d\.]+)')

    data_rows = []
    current_n = None
    current_j = None

    with open(input_filename, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            
            n_match = n_pattern.search(line)
            if n_match:
                current_n = n_match.group(2)
                continue

            j_match = j_pattern.match(line)
            if j_match:
                current_j = j_match.group(1)
                continue

            data_match = data_pattern.search(line)
            if data_match and current_n and current_j:
                benchmark_type = data_match.group(1)
                gflops = data_match.group(3)
                bandwidth = data_match.group(4)
                
                data_rows.append({
                    'Type': benchmark_type,
                    'N': current_n,
                    'J': current_j,
                    'GFLOPS': gflops,
                    'Memory Performance': bandwidth
                })

    fieldnames = ['Type', 'N', 'J', 'GFLOPS', 'Memory Performance']
    with open(output_filename, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames, delimiter=';')
        writer.writeheader()
        writer.writerows(data_rows)


# transform_md_to_csv('4070.md', 'performance_j_multi.csv')
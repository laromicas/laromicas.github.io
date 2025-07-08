#!/usr/bin/env python3
import os
from pathlib import Path
import json

def fix_json(input_file, output_file):
    with open(input_file, 'r') as file:
        data = json.load(file)

    # Replace single quotes with double quotes
    keys = data['values'][0]
    output = []
    for value in data['values'][1:]:
        row = {}
        for i, key in enumerate(keys):
            if i >= len(value):
                row[key] = None
                continue
            # Convert single quotes to double quotes in the string values
            if isinstance(value[i], str):
                value[i] = value[i].replace("'", '"')
            row[key] = value[i]
        output.append(row)

    # Write the fixed JSON to the output file
    with open(output_file, 'w') as file:
        json.dump(output, file, indent=4)

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description='Fix JSON file by replacing single quotes with double quotes.')
    parser.add_argument('input_file', type=str, help='Path to the input JSON file')

    args = parser.parse_args()
    rootdir = Path(os.getcwd()).parent
    input_file = rootdir / args.input_file
    fix_json(args.input_file, args.input_file)
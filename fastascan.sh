#!/bin/bash

# purpose is to produce a concise report about the fasta/fa files in a given folder (or its subfolders at any depth).

# The script must take two optional arguments: 
# 1. the folder X where to search files (default: current folder); 
# 2. a number of lines N (default: 0)

folder="."
lines=0

if [ -n "$1" ]; then
    folder="$1"
    echo "Chosen folder: $folder"
else
    echo "Folder to search not given. Defaulting to current dir."
fi

if [ -n "$2" ]; then
    lines="$2"
    echo "Number of lines: $lines"
else
    echo "Number of lines not given. Defaulting to zero."
fi



echo "################## Fa/Fasta REPORT ########################"

# how many such files there are

files=$(find "$folder" -type f \( -name "*.fa" -o -name "*.fasta" \))

fileCount=$(echo "$files" | wc -l)

# how many unique fasta IDs (i.e. the first words of fasta headers) they contain in total 

ids=""

echo "#######################################"
for file in $files; do
    echo "-> Analysing $file"

    if [ -h "$file" ]; then
        echo "[!] The file is a symbolic link."
    else
        echo "[x] The file is not a symbolic link."
    fi

    total_sequences=$(grep -c '^>' "$file")
    echo "[S]: There are $total_sequences number of sequences inside the file."

    first_word=$(awk '{print $1; exit}' $file)
    ids="$ids$first_word "
    sequence_length=$(awk '/^>/ {next} {gsub(/[-\n]/,""); sum += length} END {print sum}' "$file")
    echo "[L]: The total sequence length for the file is $sequence_length."

    # Check if the file contains characters specific to nucleotide sequences
    if grep -q -E '[^ACGTUNacgtun]' "$file"; then
        echo "[A]: The file contains amino acid sequences."
    else
        echo "[N]: The file contains nucleotide sequences."
    fi

    echo ""

    line_length=$(cat "$file" | wc -l)

    if [ ! $lines -eq 0 ]; then
        if [[ $line_length -le 2*$lines ]]; then
            content=$(cat "$file")
            echo "$content"
        else
            if [[ $line_length -gt 0 ]]; then
                first_lines=$(head -n "$lines" "$file")
                last_lines=$(tail -n "$lines" "$file")
                echo "$first_lines"
                echo "..."
                echo "$last_lines"
            fi
        fi
    echo ""
    fi
    echo "#######################################"
done

echo "$ids"

ids=$(echo "$ids" | tr ' ' '\n' | sort -u)


uniqueIDs=$(echo "$ids" | wc -l)

echo "=== FA/FASTA FILE COUNT: $fileCount ==="
echo "=== Unique Fasta ID COUNT: $uniqueIDs ==="



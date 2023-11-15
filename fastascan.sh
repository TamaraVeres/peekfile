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
    echo "Folder to seach not given. Defaulting to current dir."
fi

if [ -n "$2" ]; then
    lines="$2"
    echo "Number of lines: $lines"
else
    echo "Number of lines not given. Defaulting to zero."
fi



echo "################## Fa/Fasta REPORT ########################"

# how many such files there are

files=$(find $folder -type f -name "*.fa")

fileCount=$(echo "$files" | wc -l)

# how many unique fasta IDs (i.e. the first words of fasta headers) they contain in total 

ids=""

echo "#######################################"
for file in $files; do
    echo "Analysing $file"

    if [ -h "$file" ]; then
        echo "The file is a symbolic link."
    else
        echo "The file is not a symbolic link."
    fi

    total_sequences=$(grep -c '^>' "$file")
    echo "There are $total_sequences nummber of sequences inside the file."

    first_word=$(awk '{print $1; exit}' $file)
    ids="$ids$first_word "
    echo "#######################################"
done

echo "$ids"

ids=$(echo "$ids" | tr ' ' '\n' | sort -u)


uniqueIDs=$(echo "$ids" | wc -l)

echo "=== FA/FASTA FILE COUNT: $fileCount ==="
echo "=== Unique Fasta ID COUNT: $uniqueIDs ==="



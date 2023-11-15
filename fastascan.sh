#!/bin/bash

# purpose is to produce a concise report about the fasta/fa files in a given folder (or its subfolders at any depth).

# The script must take two optional arguments: 
# 1. the folder X where to search files (default: current folder); 
# 2. a number of lines N (default: 0)

folder="."
lines=0

if [ -n "$1" ]; then
    folder="$1"
fi

if [ -n "$2" ]; then
    lines="$2"
fi

echo "Chosen folder: $folder"
echo "NUmber of lines: $lines"

echo "################## Fa/Fasta REPORT ########################"

# how many such files there are

files=$(find $folder -type f -name "*.fa")

fileCount=$(echo $files | wc -l)

# how many unique fasta IDs (i.e. the first words of fasta headers) they contain in total 

uniqueIDs=$(echo "$files" | awk -F' ' '{print $1}' | sort -u | wc -l)

echo "=== Unique FA/FASTA FILE COUNT: $fileCount ==="
echo "=== Unique Fasta ID COUNT: $uniqueIDs ==="

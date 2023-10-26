filename=$1

first=$(head -n 3 "$filename")
last=$(tail -n 3 "$filename")

concatenated="$first \n ... \n $last"

echo $concatenated
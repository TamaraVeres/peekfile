filename=$1
noOfLines=$2

first=$(head -n "$noOfLines" "$filename")

last=$(tail -n "$noOfLines" "$filename")

concatenated="$first \n ... \n $last"

echo $concatenated
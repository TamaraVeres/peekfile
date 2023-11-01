filename=$1
noOfLines=$2

if [[ -z $noOfLines ]]; then
    noOfLines=3
fi

lineCount=$(cat $filename | wc -l)

if [[  $lineCount -gt 2*$noOfLines ]]; then
    cat $filename
else
    first=$(head -n "$noOfLines" "$filename")

    last=$(tail -n "$noOfLines" "$filename")

    concatenated="$first \n ... \n $last"

    echo "WARNING: LINE PRINTING STARTS!!!"

    echo $concatenated
fi
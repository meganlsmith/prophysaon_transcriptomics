while IFS= read -r line;
do
    name=alignments/$line/*MAFFT.aln
    if [ ! -f $name ]; then
        echo $name;
    fi
done < "$1"
# keep the alignments > 200 bp
keepers="alignments_g200bp"
mkdir -p $keepers
for d in alignments/* ;
do
    IFS=/ read var1 name <<< $d;
    echo $d/$name.trimAl.aln;
    line=$(head -n 1 $d/$name.trimAl.aln)
    IFS=' '  read var1 var2 var3 <<< $line;
    if (($var2 > 200));
    then
        echo 'keep';
        cp $d/$name.trimAl.aln $keepers/
    fi
done
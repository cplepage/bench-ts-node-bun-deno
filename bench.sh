
bench_script()
{
    start=`date +%s%N`
    eval $1
    end=`date +%s%N`
    echo $(($(($end - $start))/1000000))
}

exec_ts_node()
{
    echo $(bench_script "ts-node $1 $2")
}

exec_esbuild_node()
{
    outfile=$(echo $1 | sed -e 's/.ts/.js/g') 
    echo $(bench_script "esbuild $1 --log-level=silent --outfile=$outfile && node $outfile $2")
}

exec_node()
{
    outfile=$(echo $1 | sed -e 's/.ts/.js/g') 
    esbuild $1 --log-level=silent --outfile=$outfile
    echo $(bench_script "node $outfile $2")
}

exec_bun()
{
    echo $(bench_script "bun $1 $2")
}

exec_deno()
{
    echo $(bench_script "deno run $1 $2")
}

exec_esbuild()
{
    outfile=$(echo $1 | sed -e 's/.ts/.js/g') 
    echo $(bench_script "esbuild $1 --log-level=silent --outfile=$outfile")
}

echo esbuild-node: $(exec_esbuild_node $1 $2)
echo Bun: $(exec_bun $1 $2)
echo Deno: $(exec_deno $1 $2)
echo ts-node: $(exec_ts_node $1 $2)
echo node: $(exec_node $1 $2)
echo esbuild: $(exec_esbuild $1 $2)

set -e

cudaid=$1
dataset=$2
splitter=$3

cd ../../../../..

if [ ! -d "out" ];then
    mkdir out
fi

if [[ $dataset = 'fb15k-237' ]]; then
    out_channels=237
    hidden=64
elif [[ $dataset = 'wn18' ]]; then
    out_channels=18
    hidden=64
else
    out_channels=4
    hidden=1024
fi

echo "HPO starts..."

gnns=('gcn' 'sage' 'gat' 'gpr')
lrs=(0.01 0.05 0.25)
local_updates=(1 4 16)

for (( g=0; g<${#gnns[@]}; g++ ))
do
    for (( i=0; i<${#lrs[@]}; i++ ))
    do
        for (( j=0; j<${#local_updates[@]}; j++ ))
        do
            for k in {1..5}
            do
                python medscale/main.py --cfg medscale/gfl/baseline/fedavg_gcn_fullbatch_on_kg.yaml device ${cudaid} data.type ${dataset} data.splitter ${splitter} train.optimizer.lr ${lrs[$i]} train.local_update_steps ${local_updates[$j]} model.type ${gnns[$g]} model.out_channels ${out_channels} model.hidden ${hidden} seed $k >>out/${gnns[$g]}_${lrs[$i]}_${local_updates[$j]}_on_${dataset}_${splitter}.log 2>&1
            done
        done
    done
done

echo "HPO ends."

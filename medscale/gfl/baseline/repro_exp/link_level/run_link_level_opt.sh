set -e

cudaid=$1
dataset=$2
splitter=$3
gnn=$4
lr=$5
local_update=$6

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

if [[ $gnn = 'gpr' ]]; then
    layer=10
else
    layer=2
fi

echo "HPO starts..."

lr_servers=(0.5 0.1)

for (( s=0; s<${#lr_servers[@]}; s++ ))
do
    for k in {1..5}
    do
        python medscale/main.py --cfg medscale/gfl/baseline/fedavg_gcn_fullbatch_on_kg.yaml device ${cudaid} data.type ${dataset} data.splitter ${splitter} train.optimizer.lr ${lr} train.local_update_steps ${local_update} model.type ${gnn} model.out_channels ${out_channels} model.hidden ${hidden} seed $k fedopt.use True fedopt.optimizer.lr ${lr_servers[$s]} model.layer ${layer}  >>out/${gnn}_${lr}_${local_update}_on_${dataset}_${splitter}_${lr_servers[$s]}_opt.log 2>&1
    done
done

echo "HPO ends."

fast5="/home/ubuntu/data"
output_dir="/home/ubuntu/fastq"
for model in $(ls "$fast5")
do
  if [[ -d "$fast5/$model" ]]
  then
    echo $model
    for experiment_dir in $(ls "$fast5/$model")
    do
      echo "$fast5/$model/$experiment_dir/fast5"
      guppy_basecaller --input_path "$fast5/$model/$experiment_dir/fast5" --save_path "$output_dir/$model/$experiment_dir/" --config rna_r9.4.1_70bps_hac.cfg --device "cuda:0"
    done
  fi
done



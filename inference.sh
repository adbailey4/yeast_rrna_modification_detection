reference=$5
path_to_bin=$4
threads=$6
output_dir=$3
fastq=$2
fast5=$1
for model in $(ls "$fastq")
do
  if [[ -d "$fastq/$model" ]]
  then
    for experiment_dir in $(ls "$fastq/$model")
    do
      output_exp="$output_dir/$model/$experiment_dir"
      mkdir -p $output_exp
      fast5_path="$fast5/$model/$experiment_dir/fast5"
      exp_fastq="$fastq/$model/$experiment_dir/$experiment_dir.fastq"
      echo $exp_fastq
      if [ "$model" == "06102019_R941_CBF5GAL" ] || [ "$model" == "06112019_R941_CBF5GLU" ] || [ "$model" == "061719_R941_NOP58GAL" ] || [ "$model" == "06192019_R941_NOP58GLU" ] || [ "$model" == "10142019_R941_IVT" ]
      then
#        echo "Skip"
        head -20000 $exp_fastq > "$fastq/$model/$experiment_dir/$experiment_dir.5000.fastq"
        inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
          --fastq "$fastq/$model/$experiment_dir/$experiment_dir.5000.fastq" --fast5 $fast5_path --output_dir $output_exp --name $model
      else
        inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
          --fastq $exp_fastq --fast5 $fast5_path --output_dir $output_exp --name $model
      fi
    done
  fi
done

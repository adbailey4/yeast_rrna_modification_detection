threads=$6
reference=$5
path_to_bin=$4
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

      if [ "$model" == "20190610_R941_CBF5GAL" ] || [ "$model" == "20190611_R941_CBF5GLU" ] || [ "$model" == "20190617_R941_NOP58GAL" ] || [ "$model" == "20190619_R941_NOP58GLU" ] || [ "$model" == "20191014_R941_IVT" ]
      then
        echo "Large Unbarcoded MINION $exp_fastq"
        head -40000 $exp_fastq > "$fastq/$model/$experiment_dir/$experiment_dir.10000.fastq"
        inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
          --fastq "$fastq/$model/$experiment_dir/$experiment_dir.10000.fastq" --fast5 $fast5_path --output_dir $output_exp --name $model
      else
        echo "Flongle $exp_fastq"
        inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
          --fastq $exp_fastq --fast5 $fast5_path --output_dir $output_exp --name $model
      fi
    done
  fi
done

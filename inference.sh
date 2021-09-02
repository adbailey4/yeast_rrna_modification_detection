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

      if [ "$model" == "06102019_R941_CBF5GAL" ] || [ "$model" == "06112019_R941_CBF5GLU" ] || [ "$model" == "061719_R941_NOP58GAL" ] || [ "$model" == "06192019_R941_NOP58GLU" ] || [ "$model" == "10142019_R941_IVT" ]
      then
        echo "Large Unbarcoded MINION $exp_fastq"
#        head -20000 $exp_fastq > "$fastq/$model/$experiment_dir/$experiment_dir.5000.fastq"
#        inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
#          --fastq "$fastq/$model/$experiment_dir/$experiment_dir.5000.fastq" --fast5 $fast5_path --output_dir $output_exp --name $model
#      elif [ "$model" == "RNA814001" ] || [ "$model" == "RNA345944" ] || [ "$model" == "RNA442567" ] || [ "$model" == "RNA927416" ] || [ "$model" == "RNA639991" ] || [ "$model" == "RNA564572" ] || [ "$model" == "RNA873248" ] || [ "$model" == "RNA235628" ] || [ "$model" == "RNA524356" ] || [ "$model" == "RNA325982" ] || [ "$model" == "RNA113124_new" ]
      elif [ "$model" == "RNA927416" ]
      then
        for barcode in "bc_1" "bc_2" "bc_3" "bc_4"; do
          if [ -f "$fastq/$model/$experiment_dir/$experiment_dir.$barcode.fastq" ]; then
            inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
              --fastq "$fastq/$model/$experiment_dir/$experiment_dir.$barcode.fastq" --fast5 $fast5_path --output_dir $output_exp.$barcode --name $model.$barcode
          elif [[ -d "$fastq/$model/$experiment_dir/dmux_dir" ]] ; then
            find $fastq/$model/$experiment_dir/dmux_dir | grep $barcode | xargs cat > $fastq/$model/$experiment_dir/$experiment_dir.$barcode.fastq
            inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
              --fastq "$fastq/$model/$experiment_dir/$experiment_dir.$barcode.fastq" --fast5 $fast5_path --output_dir $output_exp.$barcode --name $model.$barcode
          else
            echo "Not Barcoded $fastq/$model/$experiment_dir"
          fi
        done
      else
#      elif [ "$model" == "spp382_YPD_20210720" ]; then
        echo "Flongle $exp_fastq"
        inference_pipeline.py --reference $reference --path_to_bin $path_to_bin --threads $threads \
          --fastq $exp_fastq --fast5 $fast5_path --output_dir $output_exp --name $model
      fi
    done
  fi
done

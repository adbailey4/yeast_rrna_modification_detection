fastq=$1
fast5=$2

for model in $(ls "$fastq")
do
  if [[ -d "$fastq/$model" ]]
  then
    echo $model
    for experiment_dir in $(ls "$fastq/$model")
    do
      exp="$fastq/$model/$experiment_dir/$experiment_dir"
      echo $exp
      multi_to_single_fast5 -t 16 --input_path "$fast5/$model/$experiment_dir/fast5" --save_path "$fast5/$model/$experiment_dir/split_fast5"
      embed_main index -d "$fast5/$model/$experiment_dir/split_fast5" "$exp.fastq"
      samtools view $exp.2308.18S.sorted.bam | awk '{print $1}' > $exp.2308.18S.read_ids.txt
      samtools view $exp.2308.25S.sorted.bam | awk '{print $1}' > $exp.2308.25S.read_ids.txt
      grep -f $exp.2308.18S.read_ids.txt $exp.fastq.index.readdb > $exp.18S.readdb
      grep -f $exp.2308.25S.read_ids.txt $exp.fastq.index.readdb > $exp.25S.readdb
      head -500 $exp.18S.readdb > $exp.training.readdb
      head -500 $exp.25S.readdb >> $exp.training.readdb
      tail -n +501 $exp.18S.readdb > $exp.inference.readdb
      tail -n +501 $exp.25S.readdb >> $exp.inference.readdb
      wc -l $exp.25S.readdb
    done
  fi
done
fastq=$1
output_dir=$2
mkdir -p $output_dir

for model in $(ls "$fastq")
do
  if [[ -d "$fastq/$model" ]]
  then
    for experiment_dir in $(ls "$fastq/$model")
    do
      exp_bam="$fastq/$model/$experiment_dir/$experiment_dir.2308.sorted.bam"
      exp_seq_summary="$fastq/$model/$experiment_dir/sequencing_summary.txt"
      exp_fastq="$fastq/$model/$experiment_dir/$experiment_dir.fastq"
      out_file="$output_dir/$model_$experiment_dir.html"
      pycoQC -f "$exp_seq_summary" -a "$exp_bam" -o "$out_file"

    done
  fi
done

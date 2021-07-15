fastq=$1
reference=$2
for model in $(ls "$fastq")
do
  if [[ -d "$fastq/$model" ]]
  then
    for experiment_dir in $(ls "$fastq/$model")
    do
      exp="$fastq/$model/$experiment_dir/$experiment_dir"
      echo $exp $reference
#      concat files and run minimap
      cat $fastq/$model/$experiment_dir/pass/* $fastq/$model/$experiment_dir/fail/* > "$exp.fastq"
      minimap2 --MD -t 8 -ax map-ont $reference $exp.fastq | samtools view -@ 8 -bS - | samtools sort -@ 8 - > $exp.sorted.bam && samtools view -@ 8 -bSF 2308 $exp.sorted.bam > $exp.2308.sorted.bam
      samtools index $exp.2308.sorted.bam
#      get reads for both rRNA
      rm $exp.2308.full_length*
      samtools view -hb $exp.2308.sorted.bam RDN18-1 -o $exp.2308.tmp.18S.sorted.bam
      samtools view -hb $exp.2308.sorted.bam RDN25-1 -o $exp.2308.tmp.25S.sorted.bam
      samtools rmdup $exp.2308.tmp.18S.sorted.bam $exp.2308.18S.sorted.bam && rm $exp.2308.tmp.18S.sorted.bam
      samtools rmdup $exp.2308.tmp.25S.sorted.bam $exp.2308.25S.sorted.bam && rm $exp.2308.tmp.25S.sorted.bam
      samtools index $exp.2308.25S.sorted.bam
      samtools index $exp.2308.18S.sorted.bam
    done
  fi
done



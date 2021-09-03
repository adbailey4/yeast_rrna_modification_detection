fast5=$1
fastq=$2
reference=$3

ivt="20191014_R941_IVT"
ivt_id="20191014_1845_MN20528_FAL23261_9a8cb226"
wt="20210410_R941_WT_YPD"
wt_id="20210410_1830_MN20528_AGN282_f7dbe316"

main() {
  align_and_index $ivt $ivt_id
  align_and_index $wt $wt_id

}


align_and_index() {
#             create output directory
# $1 name name
# $2 n_threads
name=$1
id=$2

exp="$fastq/$name/$id/$id"
echo "$exp.fastq"
##      concat files and run minimap
cat $fastq/$name/$id/pass/* $fastq/$name/$id/fail/* > "$exp.fastq"
minimap2 --MD -t 8 -ax map-ont $reference "$exp.fastq" | samtools view -@ 8 -bS - | samtools sort -@ 8 - > $exp.sorted.bam && samtools view -@ 8 -bSF 2308 $exp.sorted.bam > $exp.2308.sorted.bam
samtools index $exp.2308.sorted.bam
##      get reads for both rRNA
samtools view -hb $exp.2308.sorted.bam RDN18-1 -o $exp.2308.tmp.18S.sorted.bam
samtools view -hb $exp.2308.sorted.bam RDN25-1 -o $exp.2308.tmp.25S.sorted.bam
samtools rmdup $exp.2308.tmp.18S.sorted.bam $exp.2308.18S.sorted.bam && rm $exp.2308.tmp.18S.sorted.bam
samtools rmdup $exp.2308.tmp.25S.sorted.bam $exp.2308.25S.sorted.bam && rm $exp.2308.tmp.25S.sorted.bam
samtools index $exp.2308.25S.sorted.bam
samtools index $exp.2308.18S.sorted.bam
samtools view $exp.2308.18S.sorted.bam | awk '{print $1}' > $exp.2308.18S.read_ids.txt
samtools view $exp.2308.25S.sorted.bam | awk '{print $1}' > $exp.2308.25S.read_ids.txt

## Split and index fast5s
multi_to_single_fast5 -t 16 --input_path "$fast5/$name/$id/fast5" --save_path "$fast5/$name/$id/split_fast5"
embed_main index -d "$fast5/$name/$id/split_fast5" "$exp.fastq"
#
grep -f $exp.2308.18S.read_ids.txt "$exp.fastq".index.readdb > $exp.18S.readdb
grep -f $exp.2308.25S.read_ids.txt "$exp.fastq".index.readdb > $exp.25S.readdb
head -500 $exp.18S.readdb > $exp.training.readdb
head -500 $exp.25S.readdb >> $exp.training.readdb
tail -n +501 $exp.18S.readdb | head -500 > $exp.inference.readdb
tail -n +501 $exp.25S.readdb | head -500 >> $exp.inference.readdb

}

main
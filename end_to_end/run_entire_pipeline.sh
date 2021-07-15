# generate alignments
bash /home/ubuntu/yeast_rrna_modification_detection/data_preprocessing/generate_alignments.sh /home/ubuntu/fastq /home/ubuntu/yeast_rrna_modification_detection/data_preprocessing/reference/yeast_25S_18S.fa
# filter training data
bash /home/ubuntu/yeast_rrna_modification_detection/training/create_index.sh /home/ubuntu/fastq /home/ubuntu/fast5
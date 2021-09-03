# prep ivt and native data
bash /home/ubuntu/yeast_rrna_modification_detection/training/prep_ivt_and_native_data.sh /home/ubuntu/fast5 /home/ubuntu/fastq /home/ubuntu/yeast_rrna_modification_detection/training/reference/yeast_25S_18S.fa
# run training on c5.metal instance
trainModels.py run --config /home/ubuntu/yeast_rrna_modification_detection/training/train_ivt_native.config.json
# run testing on c5.metal instance
runSignalAlign.py run --config /home/ubuntu/yeast_rrna_modification_detection/testing/inference.config.json
embed_main sa2bed -d /home/ubuntu/testing/tempFiles_alignment/ivt/ -a /home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/small_variants.model -o /home/ubuntu/testing/tempFiles_alignment/ivt.bed -t 96 -c B --overwrite --rna
embed_main sa2bed -d /home/ubuntu/testing/tempFiles_alignment/wild_type/ -a /home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/small_variants.model -o /home/ubuntu/testing/tempFiles_alignment/wild_type.bed -t 96 -c B --overwrite --rna
plot_multiple_variant_accuracy.py --config /home/ubuntu/yeast_rrna_modification_detection/testing/testing_accuracy.config.json
# run inference on c5.metal instance
bash /home/ubuntu/yeast_rrna_modification_detection/inference.sh /home/ubuntu/fast5 /home/ubuntu/fastq /home/ubuntu/inference /home/ubuntu/src/signalAlign/bin /home/ubuntu/yeast_rrna_modification_detection/training/reference/yeast_25S_18S.fa 96
python3.7 /home/ubuntu/yeast_rrna_modification_detection/get_stats.py --fastq /home/ubuntu/fastq --output_dir /home/ubuntu/qc_results --reference /home/ubuntu/yeast_rrna_modification_detection/training/reference/yeast_25S_18S.fa -t 4
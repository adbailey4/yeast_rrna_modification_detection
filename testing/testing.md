## Model Testing

Once we trained the model on some WT and IVT reads we tested our model's accuracy on 500 hold out WT and IVT reads.

* In order to run training you need to alter the paths in the config file `train_ivt_native.config.json`
    * Under samples there is one named "wild_type". You need to change the paths to the corresponding file within your path system
      ```
      "positions_file": "/home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/yeast_18S_25S_modified.positions",
      "fast5_dirs": ["/home/ubuntu/"],
      "bwa_reference": "/home/ubuntu/yeast_rrna_modification_detection/data_preprocessing/reference/yeast_25S_18S.fa",
      "readdb": "/home/ubuntu/fastq/20210410_R941_WT_YPD/20210410_1830_MN20528_AGN282_f7dbe316/20210410_1830_MN20528_AGN282_f7dbe316.training.readdb",
      "alignment_file": "/home/ubuntu/fastq/20210410_R941_WT_YPD/20210410_1830_MN20528_AGN282_f7dbe316/20210410_1830_MN20528_AGN282_f7dbe316.2308.sorted.bam",
      ```
    * Under samples there is one named "ivt". You need to change the paths to the corresponding file within your path system
      ```
      "positions_file": "/home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/yeast_18S_25S_canonical.positions",
      "fast5_dirs": ["/home/ubuntu/"],
      "bwa_reference": "/home/ubuntu/yeast_rrna_modification_detection/data_preprocessing/reference/yeast_25S_18S.fa",
      "readdb": "/home/ubuntu/fastq/10142019_R941_IVT/20191014_1845_MN20528_FAL23261_9a8cb226/20191014_1845_MN20528_FAL23261_9a8cb226.training.readdb",
      "alignment_file": "/home/ubuntu/fastq/10142019_R941_IVT/20191014_1845_MN20528_FAL23261_9a8cb226/20191014_1845_MN20528_FAL23261_9a8cb226.2308.sorted.bam",
      ```
    * Finally you need to put the path to signalAlign's bin, the base model, output dir, job count (n threads), and the ambig model.
      ```
      "path_to_bin": "/home/ubuntu/src/signalAlign/bin",
      "template_hmm_model": "/home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/rna_r94_5mer_ACGTabc.model",
      "output_dir": "/home/ubuntu/training/ivt_vs_wt",
      "ambig_model": "/home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/small_variants.model",
      "job_count": 8
      ```

* `runSignalAlign run --config /home/ubuntu/yeast_rrna_modification_detection/testing/inference.config.json`
* `embed_main sa2bed -d /home/ubuntu/testing/tempFiles_alignment/ivt/ -a /home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/small_variants.model -o /home/ubuntu/testing/tempFiles_alignment/ivt.bed -t 96 -c B --overwrite --rna`
* `embed_main sa2bed -d /home/ubuntu/testing/tempFiles_alignment/wild_type/ -a /home/ubuntu/yeast_rrna_modification_detection/training/small_5mer/small_variants.model -o /home/ubuntu/testing/tempFiles_alignment/wild_type.bed -t 96 -c B --overwrite --rna`

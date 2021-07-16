## Model Training

### Preprocessing

##### Alignment
* Make sure minimap and samtools are in your PATH (`source load_environment.sh`)
* Align fastqs to reference and filter alignment files
  * `bash generate_alignments.sh path_to_fastq_dir path_to_reference`

##### Index

* In order to signalAlign to find the corresponding fast5s and fastqs you have to split and index the fast5 files.
* Simple script to split and index
  * `bash create_index.sh fastq_dir fast5_dir`
  
### IVT vs Wild Type Training

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
* Once your config file is setup, run the following command.
  * `trainModels.py run --config /home/ubuntu/yeast_rrna_modification_detection/training/train_ivt_native.config.json`
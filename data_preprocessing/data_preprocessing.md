## Data Preprocessing

### Basecalling

* Install Guppy on g4dn.xlarge AWS instance with Ubuntu 18.08
    * `bash install_guppy.sh`
* Basecall using simple script
    * `bash run_guppy.sh path_to_fast5 output_dir`

### Alignment
* Make sure minimap and samtools are in your PATH (`source load_environment.sh`)
* Align fastqs to reference and filter alignment files
    * `bash generate_alignments.sh path_to_fastq_dir path_to_reference`
## Running end to end pipeline
* The overall pipeline has two different computational requirements. Running Guppy is GPU intensive while training the model
and running inference is CPU intensive. So, downloading fast5s and basecalling is done on a GPU instance and 
  training / inference is done on a large CPU instance.
  
[comment]: <> (TODO ENA download script)

1) Start a g4dn.xlarge instance on AWS with the ubuntu18.08 image and 1000GB of storage
2) Download fast5 data from European Nucleotide Archive (ENA) under accession number PRJEB48183 into `/home/ubuntu/fast5/`
3) ```
   sudo apt-get install git
   git clone https://github.com/adbailey4/yeast_rrna_modification_detection
   source /home/ubuntu/yeast_rrna_modification_detection/load_environment.sh
   bash /home/ubuntu/yeast_rrna_modification_detection/ubuntu18_setup.sh
   bash /home/ubuntu/yeast_rrna_modification_detection/basecalling/install_guppy.sh
   ls /home/ubuntu/fast5 | xargs -I{} tar -xzf /home/ubuntu/fast5/{} -C /home/ubuntu/fast5/
   bash /home/ubuntu/yeast_rrna_modification_detection/basecalling/run_guppy.sh /home/ubuntu/fast5 /home/ubuntu/fastq
   ```
4) Once Guppy has finished, shutdown the instance, convert to a large CPU compute node (tested on c5.metal)
5) bash /home/ubuntu/yeast_rrna_modification_detection/end_to_end/run_entire_pipeline.sh
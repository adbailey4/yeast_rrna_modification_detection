## Running end to end pipeline
* The overall pipeline has two main computational loads. Running Guppy is GPU intensive while training the model
and running inference is CPU intensive. So, downloading fast5s and basecalling is done on a GPU instance and 
  training / inference is done on a large CPU instance.
  
1) Start a g4dn.xlarge instance on AWS with the ubuntu18.08 image and 1000GB of storage
2) ```
   sudo apt-get install git
   git clone https://github.com/adbailey4/yeast_rrna_modification_detection
   bash /home/ubuntu/yeast_rrna_modification_detection/ubuntu18_setup.sh
   bash /home/ubuntu/yeast_rrna_modification_detection/install_guppy.sh
   aws s3 sync s3://bailey-ares-rrna/final_data/fast5/ /home/ubuntu/fast5
   bash /home/ubuntu/yeast_rrna_modification_detection/data_preprocessing/run_guppy.sh /home/ubuntu/fast5 /home/ubuntu/fastq
   ```
3) Once Guppy has finished, shutdown the instance, convert to a large CPU compute node like c5.24xlarge
4) bash /home/ubuntu/yeast_rrna_modification_detection/end_to_end/run_entire_pipeline.sh
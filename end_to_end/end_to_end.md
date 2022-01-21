## Running end to end pipeline
* The overall pipeline has two different computational requirements. Running Guppy is GPU intensive while training the model
and running inference is CPU intensive. So, downloading fast5s and basecalling is done on a GPU instance and 
  training / inference is done on a large CPU instance.

1) Start an ubuntu18.08 image on AWS with 1000GB of storage (tested with g4dn.xlarge for basecalling)
2) Download fast5 data from European Nucleotide Archive (ENA) under accession number PRJEB48183 into `/home/ubuntu/fast5/`. (~300 GB)
   1) Use IBM's Aspera connect to download files. [Here](https://gist.github.com/adbailey4/237d0ca229f5e3c8033933a50a143348) is a gist I made for easy install.
      * `cat aspera_fast5_paths.txt | xargs -I{} $HOME/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh {} /home/ubuntu/fast5/.`
   2) Download files from from `fast5_paths.txt`.
      * `cat fast5_paths.txt | xargs -I{} wget {} -P /home/ubuntu/fast5/`
   3) Download files from ENA directly. ENA creates a zip file called `ena_files.zip`. Unizp the archive and then move all tar.gz files to `/home/ubuntu/fast5/`
      * `ls | xargs -I{} ls {} | grep tar.gz | xargs -I{} mv {} /home/ubuntu/fast5/`
3) Untar fast5 files `ls /home/ubuntu/fast5 | xargs -I{} tar -xzf /home/ubuntu/fast5/{} -C /home/ubuntu/fast5/`
4) Get fastq files
   1) OPTION 1
      1) Download fastq data from ENA under accession number PRJEB48183 into `/home/ubuntu/fastq/` 
            1) Use IBM's Aspera connect to download files. [Here](https://gist.github.com/adbailey4/237d0ca229f5e3c8033933a50a143348) is a gist I made for easy install.
               * `cat aspera_fastq_paths.txt | xargs -I{} $HOME/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh {} /home/ubuntu/fastq/.`
            2) Download files from from `fast5_paths.txt`.
               * `cat fastq_paths.txt | xargs -I{} wget {} -P /home/ubuntu/fastq/`
            3) Download files from ENA directly. ENA creates a zip file called `ena_files.zip`. Unizp the archive and then move all fastq.gz files to `/home/ubuntu/fastq/`
               * `ls | xargs -I{} ls {} | grep fastq.gz | xargs -I{} mv {} /home/ubuntu/fastq/`
      2) Gunzip fastq files `ls /home/ubuntu/fastq | xargs -I{} gunzip /home/ubuntu/fastq/{}`
      3) Run `python3 prep_fastqs.py` to place fastq files into the expected subdirectories 

   2) OPTION 2: Basecall fast5 files using guppy. It is recommended to switch to a GPU node to basecall
      1) ```
         sudo apt-get install git
         git clone https://github.com/adbailey4/yeast_rrna_modification_detection
         source /home/ubuntu/yeast_rrna_modification_detection/load_environment.sh
         bash /home/ubuntu/yeast_rrna_modification_detection/ubuntu18_setup.sh
         bash /home/ubuntu/yeast_rrna_modification_detection/basecalling/install_guppy.sh
         bash /home/ubuntu/yeast_rrna_modification_detection/basecalling/run_guppy.sh /home/ubuntu/fast5 /home/ubuntu/fastq
         ```
5) Run entire pipeline on cpu heavy compute node (tested on c5.metal). `bash /home/ubuntu/yeast_rrna_modification_detection/end_to_end/run_entire_pipeline.sh`
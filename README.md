# Single Molecule Modification Tracking of Saccharomyces Cerevisiae 18S and 25S Ribosomal RNA using Nanopore Sequencing

This is the top level directory for the pipelines, scripts, and environment setup for anyone who wants to
replicate or reproduce the results from our paper.

### Data Availablility

* Fast5
    * aws s3 sync s3://bailey-ares-rrna/final_data/fast5/ .
    * Fast5s are organized into tar.gz files with the following directory structure
```
fast5
└───date_chemistry_name
    └───date_id_instrumentID_flowcellID_runIDfast5
        │    summary_file1
        │    summary_file2
        │    ...
        └───fast5
               ID1.fast5
               ID2.fast5
               ...
```

* Fastq
    * aws s3 sync s3://bailey-ares-rrna/final_data/fastq/ .
    * Fastqs are organized into tar.gz files with the following directory structure
```
fastq
└───date_chemistry_name
    └───date_id_instrumentID_flowcellID_runIDfast5
        │    summary_file1
        │    summary_file2
        │    ...
        └───fastq
        │      ID1.fastq
        │      ID2.fastq
        │      ...
        └───alignments
               name.bam
               name.bam.bai
               ...

```

### Data Preprocessing
* Basecalling, alignment and other data preprocessing scripts can be found in [data_preprocessing](data_preprocessing/data_preprocessing.md)

### Environment setup
* The installation script for a clean ubuntu server can be found in `ubuntu18_setup.sh`. Just check if you really want to install
  all the requirements included in `ubuntu18_setup.sh`

### Training routine
* Fast5 and fastq prep and training scripts can be found in [training](training/training.md)

### Inference pipeline



## Running Everything End to End 
* If you want to download all data, basecall, align, train, and perform inference on all the data go to [end_to_end](end_to_end/end_to_end.md)
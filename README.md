# Concerted modification of nucleotides at functional centers of the ribosome revealed by single-molecule RNA modification profiling

This is the top level directory for the pipelines, scripts, and environment setup for anyone who wants to
replicate or reproduce the results from our [paper](https://www.biorxiv.org/content/10.1101/2021.12.16.472988v1).

Note: If you have issues with data access, software install or reproducing results for this paper specifically,
please create an issue on GitHub and include all relevant information and error codes. If you are interested in extending
this framework to anything other than yeast rRNA, please head to [signalAlign](https://github.com/UCSC-nanopore-cgl/signalAlign) and 
create an issue there.

## Using our Pipeline

### Docker 
The installation process for our pipeline is extensive and fragile. We highly recommend using the Dockerized the inference 
pipeline. It is the easiest way to use our model on new yeast rRNA direct nanopore sequencing datasets.  

#### Minimal Example:
* Download and prep data
  * Aspera connect is faster than wget. [Here](https://gist.github.com/adbailey4/237d0ca229f5e3c8033933a50a143348) is a gist I made for easy installation.
    * `$HOME/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR716/ERR7162397/20210415_R941_mutant451.tar.gz .`
    * `$HOME/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR777/ERR7776754/20210415_R941_mutant451.fastq.gz .`
  * Or use wget
    * `wget ftp.sra.ebi.ac.uk/vol1/run/ERR777/ERR7776754/20210415_R941_mutant451.fastq.gz`
    * `wget ftp.sra.ebi.ac.uk/vol1/run/ERR716/ERR7162397/20210415_R941_mutant451.tar.gz`
  * Extract data
    * `tar -xzf 20210415_R941_mutant451.tar.gz`
    * `gunzip 20210415_R941_mutant451.fastq.gz`
* Mount data directory and run docker
  * `docker run -it -v "$(pwd)":/data ucscbailey/yeast_rrna:latest  --fastq /data/20210415_R941_mutant451.fastq --fast5 /data/20210415_R941_mutant451/20210415_0552_MN20528_AGG125_7a2113f4/fast5 --name 20210415_R941_mutant451 --threads 2`
* Single molecule modification profile calls will be in `signalalign_output/variant_calls/20210415_R941_mutant451.csv`

### Build from source
#### Install process
There are several, specific dependencies for our pipeline which can make it difficult to install. The scripts provided here
have been built on clean ubuntu18.08 AWS instances with sudo access but things have worked on shared servers, 
but it requires more time.

```
source yeast_rrna_modification_detection/load_environment.sh
bash yeast_rrna_modification_detection/ubuntu18_setup.sh
```

#### Inference pipeline

* If the installation was performed correctly you should have `inference_pipeline.py` in your path.
```
usage: inference_pipeline.py [-h] --fastq FASTQ [--fast5 FAST5] --reference
                             REFERENCE --path_to_bin PATH_TO_BIN
                             [--output_dir OUTPUT_DIR] [--threads THREADS]
                             [--seq_summary SEQ_SUMMARY] --name NAME

Run end to end signalAlign pipeline for yeast rRNA analysis

optional arguments:
  -h, --help            show this help message and exit
  --fastq FASTQ         Path to fastq
  --fast5 FAST5         Path to fast5 directory
  --reference REFERENCE, -r REFERENCE
                        Path to reference fasta
  --path_to_bin PATH_TO_BIN
                        Path to signalalign bin folder
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        Path to output_dir
  --threads THREADS, -t THREADS
                        Number of threads
  --seq_summary SEQ_SUMMARY
                        Path to sequence summary file
  --name NAME           Name of experiment
  --embed               Run MEA during signalAlign and embed into fast5s
```
* The source of inference pipeline script can be found [here](https://github.com/adbailey4/rrna_scripts/blob/v1.0.0/src/rrna_analysis/scripts/inference_pipeline.py).



## Data Availability

* Fast5
  * Fast5s can be found at the European Nucleotide Archive (ENA) under accession number [PRJEB48183](https://www.ebi.ac.uk/ena/browser/view/PRJEB48183?show=reads)
  * Fast5s are organized into tar.gz files with the following directory structure

```
fast5.tar.gz
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
  * Fastqs can be found at the Gene Expression Omnibus (GEO) under accession number [GSE186634](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE186634)

* Modification calls
  * Modification calls can be found at the Gene Expression Omnibus (GEO) under accession number [GSE186634](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE186634)


## Replicate Results from paper

### Directory Configuration
* We have several experiments and maintained a consistent directory structure and naming convention with our Fast5 files in order to make it easier 
to process several experiments with one script. The `fast5` directory can have multiple experiments within it and has the following directory structure. 
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
As you can see, it is the same structure as the tar fast5 files.
The `fastq` directory can have multiple experiments within it and has the following directory structure. 
```
fastq
└───date_chemistry_name
    └───date_id_instrumentID_flowcellID_runIDfast5
        │    summary_file1
        │    ...
        └───fastq
               fastq
               ...
```
* If you want to download all data, basecall, align, train, and perform inference on
all the data go to [end_to_end](end_to_end/end_to_end.md)

### Basecalling

* Basecalling scripts can be found in [basecalling](basecalling/basecalling.md)

### Training routine

* Alignment, indexing and training scripts can be found in [training](training/training.md)

### Testing Pipeline

* Testing scripts can be found in [testing](testing/testing.md)

### Inference Pipeline

* There is a script that runs the inference pipeline on all experiments.
  * `bash yeast_rrna_modification_detection/inference.sh path_to_fast5s path_to_fastqs output_dir path_to_bin reference threads`
  
### QC Sequencing Runs

* We used pycoQC to QC sequencing runs. 
  * `python3.7 get_stats.py --fastq <FASTQ_TOP_DIR> --output_dir <OUTPUT_DIR> --reference <REFERENCE> -t <THREADS>>`

### Figures

* Jupyter notebooks for figures can be found in [notebooks](notebooks/notebooks.md)


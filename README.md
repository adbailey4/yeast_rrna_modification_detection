# Single Molecule Modification Tracking of Saccharomyces Cerevisiae 18S and 25S Ribosomal RNA using Nanopore Sequencing

[comment]: <> (TODO link biorxiv paper)

This is the top level directory for the pipelines, scripts, and environment setup for anyone who wants to
replicate or reproduce the results from our paper, Single-molecule modification profiling of Saccharomyces cerevisiae ribosomal RNA reveals subsets of alternatively modified ribosomes.

### Data Availablility

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

### Docker 
We have docerized the inference pipeline so that it is easy for users to use our model on new yeast rRNA direct nanopore sequecining datasets.
Minimal Example:
* Download and prep data
  * `$HOME/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR716/ERR7162397/20210415_R941_mutant451.tar.gz .`
  * `tar -xzf 20210415_R941_mutant451.tar.gz`
  * `wget https://sra-download.ncbi.nlm.nih.gov/traces/sra69/SRZ/016584/SRR16584067/20210415_R941_mutant451.fastq.gz`
  * `gunzip 20210415_R941_mutant451.fastq.gz`
* Mount data directory and run docker
  * `docker run -it -v "$(pwd)":/data ucscbailey/yeast_rrna:latest  --fastq /data/20210415_R941_mutant451.fastq --fast5 /data/20210415_R941_mutant451/20210415_0552_MN20528_AGG125_7a2113f4/fast5 --name 20210415_R941_mutant451 --threads 2`
* Single molecule modification profile calls will be in `signalalign_output/variant_calls/20210415_R941_mutant451.csv`

## Replicate Results

### Directory Configuration
* We have several experiments and maintained a consistant directory structure and naming convention with our Fast5 files in order to make it easier 
to process several expeirments with one script. The `/home/ubuntu/fast5` directory can have multiple experiments within it and has the following directory structure. 
```
/home/ubuntu/fast5
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
The `/home/ubuntu/fastq` directory can have multiple experiments within it and has the following directory structure. 
```
/home/ubuntu/fastq
└───date_chemistry_name
    └───date_id_instrumentID_flowcellID_runIDfast5
        │    summary_file1
        │    ...
        └───fastq
               fastq
               ...
```
* If you want to download all data, basecall, align, train, and perform inference on all the data go to [end_to_end](end_to_end/end_to_end.md)

### Basecalling

* Basecalling scripts can be found in [basecalling](basecalling/basecalling.md)

### Environment setup

* The installation script for a clean ubuntu server can be found in `ubuntu18_setup.sh`. Just check if you really want to install
  all the requirements included in `ubuntu18_setup.sh`

### Training routine

* Alignment, indexing and training scripts can be found in [training](training/training.md)

### Testing Pipeline

* Testing scripts can be found in [testing](testing/testing.md)


### Inference pipeline

* The inference pipeline script can be found [here](https://github.com/adbailey4/rrna_scripts/blob/v1.0.0/src/rrna_analysis/scripts/inference_pipeline.py).
* There is a script that runs the pipeline on all experiments. 
  * bash /home/ubuntu/yeast_rrna_modification_detection/inference.sh path_to_fast5s path_to_fastqs output_dir path_to_bin reference threads


### QC Sequencing Runs

* We used pycoQC to QC sequencing runs. `python3.7 get_stats.py --fastq <FASTQ_TOP_DIR> --output_dir <OUTPUT_DIR> --reference <REFERENCE> -t <THREADS>>`

### Figures

* Jupyter notebooks for figures can be found in [notebooks](notebooks/notebooks.md)


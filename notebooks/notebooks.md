# Data analysis and plotting scripts

### Download modification calls 
* Files can be found on the Gene Expression Omnibus (GEO) under accession number[GSE186634](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE186634). 
  * `wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE186nnn/GSE186634/suppl/GSE186634_RAW.tar`
  * `tar -xf GSE186634_RAW.tar`
  * `ls | xargs -I{} gunzip {}`
* Place all `csv` files into into `yeast_rrna_modification_detection/notebooks/modification_calls`

### Install read_clustering
```
git clone -b v1.0.0 https://github.com/adbailey4/read_clustering
cd read_clustering && pip install .
```

## Notebooks

* `generate_summary_data`
  * Run this notebook first. It creates several summary datasets which we use in other plotting scripts 

* `generate_clustering_plots`
  * Create clustering plots from various experiments

* `accuracy_plot`
  * Per position accuracy plot

* `percent_modification_comparison`
  * percent modification detection method comparison 

* `paper_stat_tests`
  * All statistical tests used in the paper

* `plot_experiment_kmer_distributions`
  * Plot SnoRNA KO event distributions compared to model kmer distributions

* `plot_percent_mod`
  * Plot percent modification changes from various experiments

* `plot_significant_correlations`
  * Plot correlations and change in correlations from various experiments

* `smallest_kmer_model`
  * Generate an efficient encoding of a yeast rRNA specific model without using a new character for each modification position 


### Event Clustering
1) Download and untar signalaligned output files for wild type and prp43 
   * `aws s3 sync s3://bailey-yeast-rrna-data/signalalign_events/ event_clustering`
2) Untar 
   * `cd event_clustering && tar -xzf 20210619_R941_prp43.tar.gz && rm 20210619_R941_prp43.tar.gz`
   * `tar -xzf 20210527_R941_Dbp3d_YPD.tar.gz && rm 20210527_R941_Dbp3d_YPD.tar.gz`


    
### Tombo
* Note: I do not provide install scripts for the `tombo` notebook because 
it has separate dependencies which are not required for our pipeline and was only used for validation. 
* Dependencies
  * Tombo
  * numpy
  * matplotlib
  * [py3helpers](https://github.com/adbailey4/py3helpers)
  * pandas
  * sklearn
  * scipy
  
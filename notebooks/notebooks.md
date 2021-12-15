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
The event clustering scripts require the additional argument `--embed` when running `inference_pipeline.py`. The split
fast5s will be embedded with the maximum expected accuracy (MEA) alignment path through the event to kmer alignment
probabilities. This alignment is what we use to define which events align to which reference position. MEA embedded fast5's 
are expected to be found by the notebook in the following paths.  
```
wt_path = "data/event_clustering/wt_embed"
dbp3_path = "data/event_clustering/dbp3_embed"
prp43_path = "data/event_clustering/prp43_embed"
pxr1_path = "data/event_clustering/pxr1_embed"
ivt_path = "data/event_clustering/ivt_embed"
cbf5glu_path = "data/event_clustering/cbf5glu_embed"
nop58glu_path = "data/event_clustering/nop58glu_embed"
```

However, this is not a pipeline notebook and is primarily used for data exploration. It is expected for a user to make 
their own edits so one can know exactly what they are looking at. 

    
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
  
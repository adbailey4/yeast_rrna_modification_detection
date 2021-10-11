# Data analysis and plotting scripts
Note: You need at least 10GB of disk space to run everything here and all notebooks were ran from this file's current directory.

### Download modification call files
`aws s3 sync s3://bailey-yeast-rrna-data/modification_calls/ /home/ubuntu/yeast_rrna_modification_detection/notebooks/modification_calls`

### Install read_clustering
```
git clone -b v1.0.0 https://github.com/adbailey4/read_clustering
cd read_clustering && pip install .
```

### Experiment kmer distribution plotting
1) Download and untar signalaligned output files for prp43
   * `aws s3 sync s3://bailey-yeast-rrna-data/knockout_events/ experiment_kmer_distributions`
2) Untar
   * `cd experiment_kmer_distributions && tar -xzf kmer_events.tar.gz && rm kmer_events.tar.gz`


* Event clustering
1) Download and untar signalaligned output files for wild type and prp43 
   * `aws s3 sync s3://bailey-yeast-rrna-data/signalalign_events/ event_clustering`
2) Untar 
   * `cd event_clustering && tar -xzf 20210619_R941_prp43.tar.gz && rm 20210619_R941_prp43.tar.gz`
     20210527_R941_Dbp3d_YPD.tar.gz

### Tombo
* Note: I do not provide install scripts for tombo notebook because 
it has separate dependencies which are not required for our pipeline and was only used for validation. 
* Dependencies
  * Tombo
  * numpy
  * matplotlib
  * [py3helpers](https://github.com/adbailey4/py3helpers)
  * pandas
  * sklearn
  * scipy
  
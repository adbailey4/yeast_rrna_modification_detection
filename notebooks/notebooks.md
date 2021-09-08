# Data analysis and plotting scripts

* Download modification call files
  * `aws s3 sync s3://bailey-yeast-rrna-data/modification_calls/ /home/ubuntu/yeast_rrna_modification_detection/notebooks/modification_calls`

* Install read_clustering


* Experiment kmer distribution plotting
1) Download and untar signalaligned output files for wild type and prp43
  * `aws s3 sync s3://bailey-yeast-rrna-data/knockout_events/ experiment_kmer_distributions`
2) Untar
* `cd experiment_kmer_distributions && tar -xzf kmer_events.tar.gz && rm kmer_events.tar.gz`

1) s3://bailey-yeast-rrna-data/knockout_events/kmer_events.tar.gz

* Event clustering
1) Download and untar signalaligned output files for wild type and prp43 
   * `aws s3 sync s3://bailey-yeast-rrna-data/signalalign_events/ event_clustering`
2) Untar 
  * `cd event_clustering && tar -xzf 20210410_R941_WT_YPD.tar.gz && rm 20210410_R941_WT_YPD.tar.gz && tar -xzf 20210619_R941_prp43.tar.gz && rm 20210619_R941_prp43.tar.gz`


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
  
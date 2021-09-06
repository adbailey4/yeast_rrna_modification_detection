# Data analysis and plotting scripts

* Download modification call files
  * `aws s3 sync s3://bailey-yeast-rrna-data/modification_calls/ /home/ubuntu/yeast_rrna_modification_detection/notebooks/modification_calls`

* Install read_clustering


### Tombo
* Note: I do not provide install scripts to get the either the event clustering notebook or tombo notebook to work because 
it has separate dependencies which are not required for our pipeline and was only used for validation. 
* Dependencies
  * Tombo
  * numpy
  * matplotlib
  * [py3helpers](https://github.com/adbailey4/py3helpers)
  * pandas
  * sklearn
  * scipy

* Download and untar tombo processed fast5 files for event clustering figure 
    * `aws s3 sync s3://bailey-yeast-rrna-data/tombo/ event_clustering`
    * `cd event_clustering && tar -xzf prp43_tombo_reads.tar.gz && rm prp43_tombo_reads.tar.gz && tar -xzf wild_type_tombo_reads.tar.gz && rm wild_type_tombo_reads.tar.gz`

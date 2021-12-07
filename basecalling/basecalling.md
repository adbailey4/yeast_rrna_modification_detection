## Basecalling

* Install Nvidia Drivers and Guppy on a g4dn.xlarge AWS instance with Ubuntu 18.08
  * `bash install_guppy.sh`
* Basecall using simple script. Note: this will only work if you untar our fast5 files with their 
corresponding directory structure inside the fast5 directory. See [end_to_end](../end_to_end/end_to_end.md) 
  * `bash /home/ubuntu/yeast_rrna_modification_detection/basecalling/run_guppy.sh /home/ubuntu/fast5 /home/ubuntu/fastq`

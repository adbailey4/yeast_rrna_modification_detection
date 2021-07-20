fast5=$1
fastq=$2

for model in $(ls "$fast5")
do
  if [[ -d "$fast5/$model" ]]
  then
    if [ "$model" == "RNA814001" ] || [ "$model" == "RNA345944" ] || [ "$model" == "RNA442567" ] || [ "$model" == "RNA927416" ] || [ "$model" == "RNA639991" ] || [ "$model" == "RNA563572" ] || [ "$model" == "RNA873248" ] || [ "$model" == "RNA235629" ] || [ "$model" == "RNA574356" ]
    then
#      echo $model
      for experiment_dir in $(ls "$fast5/$model")
      do
#        echo "$fast5/$model/$experiment_dir/fast5"
        echo python3.7 /home/ubuntu/src/deeplexicon/deeplexicon.py -p "$fast5/$model/$experiment_dir/fast5" -f multi -m /home/ubuntu/src/deeplexicon/models/resnet20-final.h5 -o "$fast5/$model/$experiment_dir/output.tsv"
        echo python3.7 /home/ubuntu/src/deeplexicon/fastq_splitter.py -d "$fast5/$model/$experiment_dir/output.tsv" -q "$fastq/$model/$experiment_dir/$experiment_dir.fastq" -o "$fastq/$model/$experiment_dir/dmux_dir" -s $model
      done
    fi
  fi
done




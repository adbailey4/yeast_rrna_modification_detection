fast5_dir=$1
fastq=$2
experiment=$3
n=$4

temp_dir="$fast5_dir/$experiment/$experiment/temp"
mkdir -p $temp_dir
mkdir -p "$temp_dir/dmux_output"
i=0
for fast5 in $(ls "$fast5_dir/$experiment/$experiment/fast5")
do
  ((i++))
  mkdir -p "$temp_dir/$fast5"
  cp "$fast5_dir/$experiment/$experiment/fast5/$fast5" "$temp_dir/$fast5/$fast5"
  echo $i $fast5
  python3.7 /home/ubuntu/src/deeplexicon/deeplexicon.py -p "$temp_dir/$fast5/" -f multi -m /home/ubuntu/src/deeplexicon/models/resnet20-final.h5 > $temp_dir/dmux_output/$fast5.tsv 2> /dev/null
  mkdir -p $fastq/$experiment/$experiment/dmux_dir
  python3.7 /home/ubuntu/src/deeplexicon/fastq_splitter.py -d $temp_dir/dmux_output/$fast5.tsv -q $fastq/$experiment/$experiment/$experiment.fastq -o $fastq/$experiment/$experiment/dmux_dir -s $fast5
  if [[ $i -eq $n ]]; then
    break
  fi
done


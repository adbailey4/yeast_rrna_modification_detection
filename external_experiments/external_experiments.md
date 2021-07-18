# External Data 

## SNORNA KOs

### Flongles

RNA475631 WT
RNA475632 snR60 KO
RNA475633 snR61 KO
RNA475634 snR62 KO

RNA323586 snR3_ko
RNA323585 snR34_ko
RNA323587 snR36_ko
RNA323588 wt

~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317711/RNA475631.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317712/RNA475632.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317713/RNA475633.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317714/RNA475634.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317707/RNA323586.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317708/RNA323585.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317709/RNA323587.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317710/RNA323588.fast5.tar.gz .

### Minion
RNA814001
bc1	snR3_ko
bc2	snR34_ko
bc3	snR36_ko
bc4	wt
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR529/ERR5296640/RNA814001.fast5.tar.gz .

RNA345944
bc1	WT
bc2	snR60 KO
bc3	snR61 KO
bc4	snR62 KO
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303454/RNA345944.fast5.tar.gz .

### Ribosome Fractions
REP1: RNA442567
REP2: RNA927416
bc1	WT- F1
bc2	WT- F2
bc3	WT- F3
bc4	WT- F4

~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303452/RNA442567.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303457/RNA927416.fast5.tar.gz .


### Oxidative Stress
RNA639991	rep1	MinION	Cytosolic	bc1	WT Input
MinION	Cytosolic	bc2	H2O2 Input
MinION	Cytosolic	bc3	WT Translated (F3+F4)
MinION	Cytosolic	bc4	H2O2 Translated (F3+F4)
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303451/RNA639991.fast5.tar.gz .

RNA563572	rep2	MinION	Cytosolic	bc1	WT Input
MinION	Cytosolic	bc2	H2O2 Input
MinION	Cytosolic	bc3	WT Translated (F3+F4)
MinION	Cytosolic	bc4	H2O2 Translated (F3+F4)
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303453/RNA564572.fast5.tar.gz .


RNA873248	rep1 + rep2	MinION	Cytosolic	bc1	WT Input rep1 (resequencing)
MinION	Cytosolic	bc2	H202 Input rep1 (resequencing)
MinION	Cytosolic	bc3	WT Input rep2 (resequencing)
MinION	Cytosolic	bc4	H202 Input rep2 (resequencing)
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5317944/RNA873248.fast5.tar.gz .

### Nutrient and Temp Strain
RNA235629	rep1	MinION	Total	bc1	YEP control
MinION	Total	bc2	YEP cold stress
MinION	Total	bc4	YEP heatshock stress
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5312741/RNA235628.fast5.tar.gz

RNA574356	rep2	MinION	Total	bc1	YEP control
MinION	Total	bc2	YEP cold stress
MinION	Total	bc4	YEP heatshock stress
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303482/RNA524356.fast5.tar.gz .

### PUS4 KO
RNA325982	rep1	MinION	Total	NA	Pus4 KO
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR530/ERR5303486/RNA325982.fast.tar.gz .

RNA113124	rep2	MinION	Total	NA	Pus4 KO
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR531/ERR5312742/RNA113124_new.fast5.tar.gz .


### mRNA
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR532/ERR5322115/RNA140920.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR532/ERR5322117/RNA290920.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR532/ERR5322118/RNA598723.fast5.tar.gz .
~/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/run/ERR532/ERR5322116/RNA100820.fast5.tar.gz .



## Basecalling
mkdir -p RNA475631/RNA475631/fast5
mkdir -p RNA475632/RNA475632/fast5
mkdir -p RNA475633/RNA475633/fast5
mkdir -p RNA475634/RNA475634/fast5
mkdir -p RNA323586/RNA323586/fast5
mkdir -p RNA323585/RNA323585/fast5
mkdir -p RNA323587/RNA323587/fast5
mkdir -p RNA323588/RNA323588/fast5
ls | grep -v tar | xargs -I{} tar -xzf {}.fast5.tar.gz -C {}/{}/fast5 --strip-components=1
bash /home/ubuntu/yeast_rrna_modification_detection/basecalling/run_guppy.sh /home/ubuntu/mount/external_data/fast5 /home/ubuntu/mount/external_data/fastq
bash /home/ubuntu/yeast_rrna_modification_detection/inference.sh /home/ubuntu/mount/external_data/fast5 /home/ubuntu/mount/external_data/fastq /home/ubuntu/mount/external_data/inference /home/ubuntu/src/signalAlign/bin /home/ubuntu/yeast_rrna_modification_detection/training/reference/yeast_25S_18S.fa 96

mkdir -p RNA113124_new/RNA113124_new/fast5
mkdir -p RNA323585/RNA323585/fast5
mkdir -p RNA323586/RNA323586/fast5
mkdir -p RNA323587/RNA323587/fast5
mkdir -p RNA323588/RNA323588/fast5
mkdir -p RNA32598/RNA32598/fast5
mkdir -p RNA345944/RNA345944/fast5
mkdir -p RNA442567/RNA442567/fast5
mkdir -p RNA475631/RNA475631/fast5
mkdir -p RNA475632/RNA475632/fast5
mkdir -p RNA475633/RNA475633/fast5
mkdir -p RNA475634/RNA475634/fast5
mkdir -p RNA524356/RNA524356/fast5
mkdir -p RNA564572/RNA564572/fast5
mkdir -p RNA639991/RNA639991/fast5
mkdir -p RNA814001/RNA814001/fast5
mkdir -p RNA873248/RNA873248/fast5
mkdir -p RNA927416/RNA927416/fast5

import os
from py3helpers.utils import list_dir
import shutil
fast5 = "/home/ubuntu/fast5"
fastq = "/home/ubuntu/fastq"
for path1 in list_dir(fast5, include_dirs=True):
    if os.path.isdir(path1):
        name1 = os.path.split(path1)[1]
        fastq_name = os.path.join(fastq, os.path.split(path1)[1]+".fastq")
        for path2 in list_dir(path1, include_dirs=True):
            name2 = os.path.split(path2)[1]
            if os.path.isdir(path2):
                full_path = os.path.join(fastq, name1, name2)
                if not os.path.exists(full_path):
                    os.makedirs(full_path)
                if os.path.exists(fastq_name):
                    new_name = os.path.join(full_path, name2+".fastq")
                    shutil.copyfile(fastq_name, new_name)
                    print(new_name)

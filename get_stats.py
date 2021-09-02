#!/usr/bin/env python
"""Get pycoqc stats for each experiment"""
########################################################################
# File: get_stats.py
#  executable: get_stats.py
#
# Author: Andrew Bailey
# History: 04/07/21 Created
########################################################################

from argparse import ArgumentParser
import os
from pathlib import Path
from subprocess import check_call, Popen, PIPE

import pandas as pd

from py3helpers.utils import list_dir, time_it
from pycoQC.pycoQC import pycoQC
import pysam

def parse_args():
    parser = ArgumentParser(description=__doc__)
    # required arguments
    parser.add_argument('--fastq', action='store',
                        dest='fastq', required=True, type=str, default=None,
                        help="Path to fastq")
    parser.add_argument('--reference', '-r', action='store',
                        dest='reference', required=True, type=str, default=None,
                        help="Path to reference fasta")
    parser.add_argument('--output_dir', '-o', action='store',
                        dest='output_dir', required=False, type=str, default=".",
                        help="Path to output_dir")
    parser.add_argument('--threads', '-t', action='store',
                        dest='threads', required=False, type=int, default=1,
                        help="Number of threads")
    args = parser.parse_args()
    return args


def get_basic_qc_stats(seq_summary, bam):
    p = pycoQC(
        summary_file=seq_summary,
        bam_file=bam, quiet=True)
    summary = p.summary_stats_dict()
    return_dict = {}
    return_dict["run_duration"] = summary["All Reads"]["run"]["run_duration"]
    return_dict["active_channels"] = summary["All Reads"]["run"]["active_channels"]
    return_dict["basecall_reads_number"] = summary["All Reads"]["basecall"]["reads_number"]
    return_dict["basecall_bases_number"] = summary["All Reads"]["basecall"]["bases_number"]
    return_dict["alignment_reads_number"] = summary["All Reads"]["alignment"]["reads_number"]
    return_dict["alignment_bases_number"] = summary["All Reads"]["alignment"]["bases_number"]
    with pysam.AlignmentFile(bam, "rb") as samfile:
        return_dict["full_length_18S"] = samfile.count('RDN18-1', 1, 15)
        return_dict["full_length_25S"] = samfile.count('RDN25-1', 1, 15)

    return return_dict


def align_and_filter(fastq, reference, threads=1):
    """Align reads using minimap and filter bam files"""
    out_bam = os.path.splitext(fastq)[0] + ".bam"
    filtered_sorted_bam = os.path.splitext(fastq)[0] + ".2308.sorted.bam"
    p1 = Popen(f"minimap2 --MD -t {threads} -ax map-ont {reference} {fastq}".split(), stdout=PIPE)
    p2 = Popen(f"samtools sort -@ {threads} ".split(), stdin=p1.stdout, stdout=PIPE)
    p1.stdout.close()
    p3 = Popen(f"samtools view -h -@ {threads} -o {out_bam}".split(), stdin=p2.stdout, stdout=PIPE)
    p2.wait()
    p2.stdout.close()
    p3.wait()
    rcode = p3.returncode
    assert rcode == 0, "Return code is not 0, check input paths and if both minimap2 and samtools are installed"
    check_call(f"samtools index -@ {threads} {out_bam}".split())
    p4 = Popen(f"samtools view -@ {threads} -bSF 2308 {out_bam} -o {filtered_sorted_bam}".split(), stdout=PIPE)
    p4.wait()
    rcode = p4.returncode
    assert rcode == 0, "Return code is not 0, check input paths and if both minimap2 and samtools are installed"
    check_call(f"samtools index -@ {threads} {filtered_sorted_bam}".split())
    return out_bam, filtered_sorted_bam


def main():
    args = parse_args()
    print("Align and filter BAM")
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    out_path = os.path.join(output_dir, "sequencing_stats.csv")
    all_stats = {}

    for experiment_path in list_dir(args.fastq, include_dirs=True):
        if os.path.isdir(experiment_path):
            experiment = os.path.split(experiment_path)[1]
            for run_path in list_dir(experiment_path, include_dirs=True):
                if os.path.isdir(run_path):
                    run_id = os.path.split(run_path)[1]
                    name = f"{experiment}.{run_id}"
                    exp = os.path.join(run_path, run_id)
                    fastq = exp + ".fastq"
                    sorted_bam = exp + ".2308.sorted.bam"
                    seq_summary = os.path.join(run_path, "sequencing_summary.txt")
                    if not os.path.exists(sorted_bam):
                        _, sorted_bam = align_and_filter(fastq, args.reference, threads=args.threads)
                    if not os.path.exists(sorted_bam + ".bai"):
                        check_call(f"samtools index -@ {args.threads} {sorted_bam}".split())
                    if os.path.exists(seq_summary):
                        stats = get_basic_qc_stats(seq_summary, sorted_bam)
                        stats["name"] = experiment
                        stats["run_id"] = run_id
                        all_stats[name] = stats
                    else:
                        print(f"Skipping {name}")

    all_data = pd.DataFrame(all_stats).T
    all_data[["name", "run_id", "run_duration", "active_channels", "basecall_reads_number", "basecall_bases_number",
              "alignment_reads_number", "alignment_bases_number", "full_length_18S", "full_length_25S"]].to_csv(out_path, index=False)


if __name__ == '__main__':
    ret, time = (time_it(main))
    print(f"Running Time: {time} s")

#!/usr/bin/env bash
set -e

# Fix ownership of output files
finish() {
    # Fix ownership of output files
    user_id=$(stat -c '%u:%g' /data)
    chown -R ${user_id} /data
}
trap finish EXIT

# Call tool with parameters
inference_pipeline.py --path_to_bin /root/signalAlign/bin --output_dir /data/ --reference /root/rrna_scripts/yeast_25S_18S.fa "$@"

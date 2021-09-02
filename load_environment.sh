#!/bin/bash
cwd=`pwd`
export PATH="$PATH:$cwd/src/cmake/bin"
export PATH="$PATH:$cwd/src/bwa/"
export PATH="$PATH:$cwd/src/minimap2/"
export PATH="$PATH:/usr/local/bin:/home/ubuntu/.local/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# syntax = docker/dockerfile:1.0-experimental
FROM baileybase/embed_dependencies:v0.0.1 AS build
MAINTAINER Andrew Bailey, andbaile@ucsc.edu

ENV VIRTUAL_ENV=/opt/venv
RUN python3.7 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# cryptography needed for moto[s3] but new versions need rust installed
RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip -q install wheel
#RUN python3.7 -m pip -q install wheel cryptography==2.3.0 moto[s3]==1.3.14

ENV BUILD_SHARED_LIBS="OFF"
RUN git clone --recursive --single-branch -b 1.0.0 https://github.com/adbailey4/embed_fast5.git && \
    cd /root/embed_fast5 && \
    python3.7 -m pip install .

# install bwa
WORKDIR /root/
RUN git clone https://github.com/lh3/bwa.git && \
    cd bwa && \
    make && \
    cp bwa /opt/venv/bin

WORKDIR /home/
RUN git clone --recursive --single-branch -b v1.0.0 https://github.com/UCSC-nanopore-cgl/signalAlign.git
RUN mkdir /home/signalAlign/build && \
    cd /home/signalAlign/sonLib && \
    make clean && \
    cd /home/signalAlign/externalTools && \
    make clean && \
    cd /home/signalAlign/build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=. -DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=RELEASE && \
    make -j 4 && \
    cd /home/signalAlign && \
    python3.7 -m pip install . && \
    mkdir /root/signalAlign && mkdir /root/signalAlign/build && \
    cp -r /home/signalAlign/build /root/signalAlign && \
    mkdir /root/signalAlign/bin && \
    cp -r /home/signalAlign/bin /root/signalAlign && \
    cp -r /home/signalAlign/Docker/run_wrapper.sh /root/signalAlign/run_wrapper.sh && \
    rm -rf /home/signalAlign/tests

WORKDIR /home/
# install minimap2
RUN git clone -b v2.23 https://github.com/lh3/minimap2 && \
    cd minimap2 && \
    make && \
    cp minimap2 /opt/venv/bin

WORKDIR /home/
# install rrna-scripts
RUN git clone -b v1.0.1 https://github.com/adbailey4/rrna_scripts && \
    cd rrna_scripts && \
    python3.7 -m pip install .

# install ont-fast5-api
RUN python3.7 -m pip install ont-fast5-api

WORKDIR /home/
RUN apt-get update && apt-get install -y libzstd-dev
# install vbz_compression
RUN git clone -b v1.0.1 https://github.com/nanoporetech/vbz_compression.git && \
    cd vbz_compression && \
    git submodule update --init && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D ENABLE_CONAN=OFF -D ENABLE_PERF_TESTING=OFF -D ENABLE_PYTHON=OFF .. && \
    make -j 4 && \
    make install

COPY ./Docker/run_wrapper.sh /home/rrna_scripts
COPY ./training/reference/yeast_25S_18S.fa /home/rrna_scripts

FROM ubuntu:18.04 as runtime
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3.7 python3.7-venv libgomp1 libcurl4-openssl-dev samtools hdf5-tools && \
    apt-get clean && \
    apt-get purge


COPY --from=build /root/signalAlign/ /root/signalAlign/
COPY --from=build /home/rrna_scripts/ /root/rrna_scripts/
COPY --from=build /opt/venv /opt/venv

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:/root/signalAlign/bin:$PATH"


RUN mkdir /data
WORKDIR /data

ENTRYPOINT ["sh", "/root/rrna_scripts/run_wrapper.sh"]

#FROM runtime as test
#RUN apt-get -qq install -y --no-install-recommends python3-distutils
#RUN python3.7 -m pip -q install pytest
#
#COPY ./src/signalalign/tests /root/signalAlign/src/signalalign/tests
#
#RUN cd /root/signalAlign && python3.7 -m pytest
#WORKDIR /root/signalAlign

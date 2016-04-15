FROM ubuntu:14.04

RUN apt-get -y update && \
	apt-get install -y python && \
	apt-get install -y python-pip python-dev build-essential && \
	apt-get install -y wget zip bzip2 && \ 
	apt-get install -y gcc && \ 
	apt-get install -y zlib1g-dev && \
	apt-get install -y libcurl4-gnutls-dev && \
	apt-get install -y libssl-dev && \
	apt-get install -y samtools
	
RUN pip install pysam && \
	pip install biopython

WORKDIR /opt

RUN wget https://sourceforge.net/projects/prada/files/pyPRADA/pyPRADA_1.2.tar.gz/download && \
	mv download pyPRADA_1.2.tar.gz && \ 
	tar zxvf pyPRADA_1.2.tar.gz 

ENV PATH /opt/pyPRADA_1.2:/usr/bin:/bin

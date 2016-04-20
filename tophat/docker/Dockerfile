FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get install -y wget zip bzip2 python git
RUN apt-get install -y tophat 
RUN apt-get install -y bowtie 
RUN apt-get install -y samtools
RUN apt-get install -y bowtie2

#Install converter
RUN git clone https://github.com/Sage-Bionetworks/SMC-RNA-Examples.git && \
	cp SMC-RNA-Examples/tophat/script/convert_tophat_to_bedpe.py /usr/local/bin/

ENV PATH /usr/local/bin/:/usr/bin:/bin

FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get install -y wget zip bzip2
RUN apt-get install -y tophat 
RUN apt-get install -y bowtie 
RUN apt-get install -y samtools
RUN apt-get install -y bowtie2

ENV PATH /usr/local/bin/:/usr/bin:/bin

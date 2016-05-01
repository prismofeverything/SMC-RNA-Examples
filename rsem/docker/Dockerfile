FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y g++ make python libboost-dev libboost-thread-dev libboost-system-dev zlib1g-dev ncurses-dev libxml2-dev libxslt-dev python-dev python-pip git gcc libdb5.1 libdb5.1-dev
RUN apt-get install -y samtools

WORKDIR /opt

RUN git clone https://github.com/deweylab/RSEM.git && \
	cd RSEM && \ 
	make && \
	make install




FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y curl wget g++ make python libboost-dev libboost-thread-dev libboost-system-dev zlib1g-dev ncurses-dev unzip gzip bzip2 libxml2-dev libxslt-dev python-dev python-pip git gcc libdb5.1 libdb5.1-dev
RUN apt-get install -y samtools

WORKDIR /opt

RUN git clone --recursive https://github.com/alexdobin/STAR.git && \
	cd STAR && \
	make STAR && \
	cp bin/Linux_x86_64/STAR /usr/local/bin/

RUN git clone --recursive https://github.com/STAR-Fusion/STAR-Fusion.git

RUN cpan install Set::IntervalTree 

RUN cpan install DB_File

RUN apt-get install -y bowtie
RUN wget http://research-pub.gene.com/gmap/src/gmap-gsnap-2016-04-04.tar.gz && \
	tar -zvxf gmap-gsnap-2016-04-04.tar.gz && \
	cd gmap-2016-04-04/ && \
	./configure && \
	make && \
	make install

RUN cpan install URI::Escape 

ENV PATH /opt/STAR-Fusion/:/usr/local/bin/:/usr/bin:/bin


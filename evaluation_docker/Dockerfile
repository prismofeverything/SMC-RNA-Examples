FROM ubuntu:14.04
#Install Essentials
RUN apt-get -y update && \
	apt-get install -y git && \
	apt-get install -y build-essential && \
	apt-get install -y cmake && \
	apt-get install -y gcc && \
	apt-get install -y python

#Install Evaluator
WORKDIR /opt
RUN git clone https://github.com/Sage-Bionetworks/SMC-RNA-Challenge.git && \
	cd SMC-RNA-Challenge && \
	cp evaluation.py /usr/local/bin/ && \
	mkdir build && \
	cd build && \
	cmake ../FusionEvaluator_0_1_2/ -DCMAKE_BUILD_TYPE=release && \
	make && \
	cp bin/fusionToolEvaluator /usr/local/bin/

ENV PATH /usr/local/bin/:/usr/bin:/bin

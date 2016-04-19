FROM ubuntu
#Install Essentials
RUN apt-get -y update
RUN apt-get install -y git build-essential cmake gcc python

#Install converter, evaluator, validator
WORKDIR /opt
RUN git clone https://github.com/Sage-Bionetworks/SMC-RNA-Challenge.git && \
	cd SMC-RNA-Challenge && \
	cp evaluation.py /usr/local/bin/ && \
	cp convert_tophapt_to_bedpe.py /usr/local/bin/ && \
	mkdir build && \
	cd build && \
	cmake ../FusionEvaluator_0_1_2/ -DCMAKE_BUILD_TYPE=release && \
	make && \
	cp bin/fusionToolEvaluator /usr/local/bin/

ENV PATH /usr/local/bin/:/usr/bin:/bin

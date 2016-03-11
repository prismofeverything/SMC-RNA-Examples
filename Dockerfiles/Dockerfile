FROM ubuntu:14.04

RUN "sh" "-c" "echo nameserver 8.8.8.8 >> /etc/resolv.conf"
RUN "sh" "-c" "echo nameserver 8.8.4.4 >> /etc/resolv.conf"
RUN "sh" "-c" 'echo DOCKER_OPTS="--dns 8.8.8.8 --dns 192.168.100.102" >> /etc/default/docker'

RUN apt-get -y update && \
	apt-get install -y wget zip bzip2 && \
	apt-get install -y tophat && \
	apt-get install -y bowtie && \ 
	apt-get install -y samtools


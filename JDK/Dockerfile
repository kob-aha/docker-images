FROM ubuntu:14.04

MAINTAINER kobyaha <kobyahron@gmail.com>

# Download necessary packages for installing Oracle JDK 7
RUN apt-get update -q
RUN apt-get install -q -y software-properties-common
RUN apt-get install -q -y python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update

# Auto accept oracle jdk license and install latest JDK7
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/
ENV PATH $PATH:$JAVA_HOME/bin

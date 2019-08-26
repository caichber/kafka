FROM openshift/base-centos7

ENV BUILDER_VERSION 1.0

LABEL maintainer="Christian Aichberger <christian.aichberger@brz.gv.at>"

# Install Java
RUN INSTALL_PKGS="java-11-openjdk java-11-openjdk-devel wget" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y 


#COPY kafka_2.12-2.3.0.tgz .
RUN wget http://mirror.klaus-uwe.me/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz

RUN mkdir /opt/kafka 
RUN chmod -R a=u /opt/kafka
RUN chown -R 1001:1001 /opt/kafka
RUN tar -C /opt/kafka -xvf kafka_2.12-2.3.0.tgz --strip-components 1
USER 1001

WORKDIR /opt/kafka
VOLUME /tmp/kafka-logs /tmp/zookeeper
EXPOSE 2181 2888 3888 9092



# Use the latest docket official image of ubuntu
FROM ubuntu

# Specify to working directory
WORKDIR /usr/proj
ADD . /usr/proj

# Update apt-get
RUN apt-get -y update && apt-get -y upgrade

# Install wget
RUN apt-get -y install wget

# Install git
RUN apt-get -y install git

# Install vim
RUN apt-get -y install vim

# Install make 
RUN apt-get -y install build-essential

# Install java 11
RUN apt-get -y install openjdk-11-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64

# Install Maven and include in path
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
RUN tar -xvf apache-maven-3.9.9-bin.tar.gz && rm apache-maven-3.9.9-bin.tar.gz
RUN mv apache-maven-3.9.9 /opt/
ENV PATH=/opt/apache-maven-3.9.9/bin:$PATH

# Install scala 2.12.0 and include in path
RUN wget https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz
RUN gzip -d cs-aarch64-pc-linux.gz
RUN mkdir /opt/coursier && mv cs-aarch64-pc-linux /opt/coursier/cs
RUN chmod +x /opt/coursier/cs
ENV PATH=~/.local/share/coursier/bin:/opt/coursier:$PATH
RUN cs setup --yes

# Install hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz
RUN tar -xvf hadoop-3.4.0.tar.gz && rm hadoop-3.4.0.tar.gz
RUN mv hadoop-3.4.0 /opt/
ENV PATH=/opt/hadoop-3.4.0/bin:$PATH
ENV HADOOP_HOME=/opt/hadoop-3.4.0

# Install spark
RUN wget https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz
RUN tar -xvf spark-3.5.3-bin-hadoop3.tgz && rm spark-3.5.3-bin-hadoop3.tgz
RUN mv spark-3.5.3-bin-hadoop3 /opt/
ENV PATH=/opt/spark-3.5.3-bin-hadoop3/bin:$PATH
ENV SPARK_HOME=/opt/spark-3.5.3-bin-hadoop3

# Install thrift to use parquet-java (from parquet-java github)
RUN wget -nv https://archive.apache.org/dist/thrift/0.21.0/thrift-0.21.0.tar.gz
RUN tar -xzf thrift-0.21.0.tar.gz && rm thrift-0.21.0.tar.gz
RUN mv thrift-0.21.0 /opt/
RUN chmod +x /opt/thrift-0.21.0/configure
WORKDIR /opt/thrift-0.21.0
RUN ./configure --disable-libs
RUN make install -j
WORKDIR /usr/proj

# Add Wayang to env
ENV WAYANG_HOME=/usr/proj/incubator-wayang/wayang-assembly/target/wayang-0.7.1
ENV PATH=/usr/proj/incubator-wayang/wayang-assembly/target/wayang-0.7.1/bin:$PATH


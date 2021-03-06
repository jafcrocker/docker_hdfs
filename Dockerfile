FROM zenoss/centos-base:1.0.2-java

RUN yum install -y ssh rsync

RUN groupadd -g 106 -r hadoop    && \
    groupadd -g 109 -r hdfs && \
    useradd  -u 105 -g hdfs -r hdfs -d /var/lib/hadoop-hdfs -s /bin/bash -c "Hadoop HDFS" -G hadoop

RUN mkdir -p /var/hdfs/data
RUN mkdir -p /var/hdfs/secondary

#RUN wget -qO- https://archive.apache.org/dist/hadoop/common/hadoop-2.5.2/hadoop-2.5.2.tar.gz | tar -C /opt -xz
ADD hadoop-2.5.2.tar.gz /opt
RUN ln -s /opt/hadoop-2.5.2 /opt/hadoop

ADD hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
RUN /opt/hadoop/bin/hdfs namenode -format

ADD run-hdfs-namenode /usr/bin/run-hdfs-namenode
ADD run-hdfs-secondarynamenode /usr/bin/run-hdfs-secondary-namenode
ADD run-hdfs-datanode /usr/bin/run-hdfs-datanode


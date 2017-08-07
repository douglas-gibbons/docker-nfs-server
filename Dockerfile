FROM centos
RUN yum -y install /usr/bin/ps nfs-utils && yum clean all
RUN mkdir -p /exports

COPY entrypoint.sh /

RUN echo "nfs             2049/tcp" >> /etc/services
RUN echo "nfs             111/udp" >> /etc/services

EXPOSE 111/tcp 111/udp 2049/tcp 20048/tcp
ENTRYPOINT ["/entrypoint.sh"]

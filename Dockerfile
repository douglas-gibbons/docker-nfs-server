FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y nfs-kernel-server runit inotify-tools -qq
RUN mkdir -p /exports

COPY entrypoint.sh /

RUN echo "nfs             2049/tcp" >> /etc/services
RUN echo "nfs             111/udp" >> /etc/services

EXPOSE 111/udp 2049/tcp 20048/tcp
ENTRYPOINT ["/entrypoint.sh"]

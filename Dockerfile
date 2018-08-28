FROM centos:6.10

COPY varnish41.repo /etc/yum.repos.d/varnish41.repo

RUN yum install epel-release -y && \
    yum update -y && \
    yum install varnish -y && \
    yum clean all && \
    mkdir -p /opt/lib && \
    cp -a /usr/lib64/libjemalloc.so.* /opt/lib && \
    cp -a /lib64/libpcre.so.* /opt/lib && \
    cp -a --parents /usr/lib64 /opt && \
    cp -a --parents /var/lib/varnish /opt && \
    cp -a --parents /lib64 /opt && \
    cp -a --parents /etc/varnish && \
    cp -a --parents /usr/lib/gcc /opt && \
    cp -a --parents /usr/sbin/varnishd /opt && \
    cp -a --parents /bin/sh /opt && \
    cp -a --parents /usr/libexec/gcc /opt && \
    cp -a --parents /usr/bin /opt

FROM gcr.io/distroless/base

COPY --from=0 /opt /

CMD [ "varnishd", "-F" ]
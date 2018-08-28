FROM centos:6.10

COPY varnish41.repo /etc/yum.repos.d/varnish41.repo

RUN yum install epel-release -y && \
    yum update -y && \
    yum install varnish -y && \
    yum clean all && \
	mkdir -p /opt/lib && \
    cp -a /usr/lib64/libjemalloc.so.* /opt/lib && \
    cp -a /lib64/libpcre.so.* /opt/lib && \
    cp -a --parents /usr/lib64/varnish /opt && \
    cp -a --parents /lib64/libdl.so.* /opt && \
    cp -a --parents /lib64/libnsl.so.* /opt && \
    cp -a --parents /lib64/libm.so.* /opt && \
    cp -a --parents /lib64/libpthread.so.* /opt && \
    cp -a --parents /lib64/libc.so.* /opt && \
    cp -a --parents /lib64/librt.so.* /opt && \
    cp -a --parents /usr/lib/gcc /opt && \
    cp -a --parents /usr/sbin/varnishd /opt && \
    cp -a --parents /bin/sh /opt && \
    cp -a --parents /usr/libexec/gcc /opt && \
    cp -a --parents /usr/bin /opt

FROM gcr.io/distroless/base

VOLUME [ "/var/lib/varnish" ]

COPY --from=0 /opt /

ENTRYPOINT [ "varnishd", "-F" ]
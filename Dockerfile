FROM centos:6.10

COPY varnish41.repo /etc/yum.repos.d/varnish41.repo

RUN yum install epel-release -y && \
    yum update -y && \
    yum install varnish -y && \
    yum clean all

RUN cp -a --parents /usr/bin/varnish* /opt && \
    cp -a --parents /usr/bin/gcc /opt && \
    cp -a --parents /usr/bin/as /opt && \
    cp -a --parents /usr/bin/ld /opt && \
    cp -a --parents /usr/lib64/varnish /opt && \
    cp -a --parents /usr/lib64/libjemalloc.so.* /opt && \
    cp -a --parents /usr/lib64/libvarnishapi.so.* /opt && \
    cp -a --parents /usr/lib64/libmpfr.so.* /opt && \
    cp -a --parents /usr/lib64/libgmp.so.* /opt && \
    cp -a --parents /usr/lib64/libedit.so.* /opt && \
    cp -a --parents /usr/lib64/libopcodes-2.20.51.0.2-5.48.el6.so /opt && \
    cp -a --parents /usr/lib64/libbfd-2.20.51.0.2-5.48.el6.so /opt && \
    cp -a --parents /usr/lib64/crt* /opt && \
    cp -a --parents /usr/lib64/libpthread* /opt && \
    cp -a --parents /usr/lib64/libc* /opt && \
    cp -a --parents /lib64/libtinfo.so.* /opt && \
    cp -a --parents /usr/lib/gcc /opt && \
    cp -a --parents /usr/libexec/gcc /opt && \
    cp -a --parents /usr/sbin/varnishd /opt && \
    cp -a --parents /etc/varnish /opt

FROM gcr.io/distroless/base

COPY --from=0 /opt /
COPY --from=0 /lib64 /lib64
COPY --from=0 /bin/sh /bin/sh

VOLUME /var/lib/varnish

CMD [ "varnishd", "-F" ]

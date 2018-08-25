FROM centos:6.10

COPY varnish41.repo /etc/yum.repos.d/varnish41.repo

RUN yum install epel-release -y && \
    yum install varnish -y && \
    yum clean all

FROM gcr.io/distroless/base

COPY --from=0 /usr/lib64/libjemalloc.so.1 /lib/libjemalloc.so.1
COPY --from=0 /usr/lib64 /usr/lib64
COPY --from=0 /usr/lib/gcc /usr/lib/gcc
COPY --from=0 /lib64 /lib64
COPY --from=0 /var/log/varnish /var/log/varnish
COPY --from=0 /usr/sbin/varnishd /usr/sbin/varnishd
COPY --from=0 /var/lib/varnish /var/lib/varnish
COPY --from=0 /etc/varnish /etc/varnish
COPY --from=0 /bin/sh /bin/sh
COPY --from=0 /usr/bin /usr/bin
COPY --from=0 /usr/libexec/gcc /usr/libexec/gcc

ENTRYPOINT [ "varnishd", "-F" ]

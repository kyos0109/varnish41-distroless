FROM centos:6.10

COPY varnish41.repo /etc/yum.repos.d/varnish41.repo

RUN yum install epel-release -y && \
    yum install varnish -y && \
    yum clean all

FROM gcr.io/distroless/base

COPY --from=0 /usr/lib64/libjemalloc.so.1 /lib/libjemalloc.so.1
COPY --from=0 /usr/lib64/libjemalloc.so.1 /usr/lib64/libjemalloc.so.1
COPY --from=0 /usr/lib64/varnish /usr/lib64/varnish
COPY --from=0 /lib64 /lib64
COPY --from=0 /usr/sbin/varnishd /usr/sbin/varnishd
COPY --from=0 /var/lib/varnish /var/lib/varnish

ENTRYPOINT [ "varnishd", "-F" ]

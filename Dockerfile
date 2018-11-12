FROM centos:6.10

# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ARG TIME_ZONE

COPY varnish41.repo /etc/yum.repos.d/varnish41.repo

RUN yum install epel-release -y && \
    yum update -y && \
    yum install varnish -y && \
    yum clean all

RUN mkdir -p /opt/var/lib/varnish && \
    cp -a --parents /usr/bin/varnish* /opt && \
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
    cp -a --parents /usr/lib64/libcidn.so /opt && \
    cp -a --parents /usr/lib64/libgomp.so.* /opt && \
    cp -a --parents /usr/lib/gcc /opt && \
    cp -a --parents /usr/libexec/gcc /opt && \
    cp -a --parents /usr/sbin/varnishd /opt && \
    cp -a --parents /lib64/ld-2.12.so /opt && \
    cp -a --parents /lib64/ld-linux-x86-64.so.* /opt && \
    cp -a --parents /lib64/libbz2.so.* /opt && \
    cp -a --parents /lib64/libc-2.12.so /opt && \
    cp -a --parents /lib64/libc.so.* /opt && \
    cp -a --parents /lib64/libcap.so.* /opt && \
    cp -a --parents /lib64/libcrypt* /opt && \
    cp -a --parents /lib64/libm-2.12.so /opt && \
    cp -a --parents /lib64/libm.so.* /opt && \
    cp -a --parents /lib64/libpcre.so.* /opt && \
    cp -a --parents /lib64/libpthread* /opt && \
    cp -a --parents /lib64/libz.so.* /opt && \
    cp -a --parents /lib64/libdl* /opt && \
    cp -a --parents /lib64/libnsl* /opt && \
    cp -a --parents /lib64/librt* /opt && \
    cp -a --parents /lib64/libncurses.so.* /opt && \
    cp -a --parents /lib64/libtinfo.so.* /opt && \
    cp -a --parents /lib64/libncursesw.so.* /opt && \
    cp -a --parents /lib64/libresolv* /opt && \
    cp -a --parents /lib64/libuuid* /opt && \
    cp -a --parents /lib64/libutil* /opt && \
    cp -a --parents /lib64/libnss_compat* /opt && \
    cp -a --parents /lib64/libnss_dns* /opt && \
    cp -a --parents /lib64/libnss_files* /opt && \
    cp -a --parents /lib64/libnss_hesiod* /opt && \
    cp -a --parents /lib64/libcidn* /opt && \
    cp -a --parents /lib64/libgcc_s* /opt && \
    cp -a --parents /etc/varnish /opt && \
    cp -a --parents /usr/share/terminfo/x /opt && \
    cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime

FROM gcr.io/distroless/base

COPY --from=0 /opt /
COPY --from=0 /bin/sh /bin/sh

ENTRYPOINT [ "varnishd", "-F" ]

CMD [ "-h" ]

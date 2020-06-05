FROM centos:7

COPY *.repo /etc/yum.repos.d/

RUN yum install -y make gcc && \
    yum install -y contrail-vrouter-source && \
    mkdir -p /opt/contrail/src/ /vrouter_src && \
    mv /usr/src/* /opt/contrail/src/ && \
    vrouter_path=$(find /opt/contrail/src -type f -name "contrail-vrouter-*.tar.gz") && \
    cd  /vrouter_src && \
    tar -xf "${vrouter_path}" && \
    yum clean all -y && \
    rm -rf /var/cache/yum;

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

LABEL "com.atsgen.tungsten.container.name"="tungsten-vrouter-kernel-build-init"

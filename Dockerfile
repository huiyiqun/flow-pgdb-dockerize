FROM centos:7

ENV FLOW_PGDB_VER 0.74

#RUN sed -i "s_mirrorlist=_#mirrorlist=_" /etc/yum.repos.d/CentOS-Base.repo && \
    #sed -i "s_#baseurl=http://mirror.centos.org/_baseurl=https://mirrors.tuna.tsinghua.edu.cn/_" /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y && yum groupinstall -y 'Development Tools' && \
    yum install -y wget postgresql-devel zlib-devel

RUN wget -c -t 0 --retry-connrefused https://master.dl.sourceforge.net/project/flow-pgdb/flow-pgdb-${FLOW_PGDB_VER}.tgz && \
    tar xfvz flow-pgdb-${FLOW_PGDB_VER}.tgz && rm flow-pgdb-${FLOW_PGDB_VER}.tgz

WORKDIR flow-pgdb-0.74/

RUN ./configure && make install

ENTRYPOINT ["flow-pgdb"]

FROM centos:centos7
MAINTAINER Lucas <lucasvs@outlook.com>
ENV VERSION 5.0.x

# -------------------- Yum installs
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y nano wget inotify-tools rsyslog
RUN wget -O /etc/yum.repos.d/kamailio.repo http://download.opensuse.org/repositories/home:/kamailio:/v${VERSION}-rpms/CentOS_7/home:kamailio:v${VERSION}-rpms.repo
RUN yum install -y kamailio

# -------------------- Kamailio configs

RUN echo "local0.*                        -/var/log/kamailio.log" >> /etc/rsyslog.conf

COPY run.sh /run.sh
COPY dispatcher_watch.sh /

EXPOSE 5060/udp

CMD /run.sh

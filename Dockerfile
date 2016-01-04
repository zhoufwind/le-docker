FROM dockerhub.hjidc.com/centos:7.2.1511

MAINTAINER Feng Zhou <zhoufeng@hujiang.com>

RUN rm -f /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

RUN mkdir -p /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys

COPY epel-release-latest-7.noarch.rpm /usr/local/src/epel-release-latest-7.noarch.rpm
RUN rpm -ivh /usr/local/src/epel-release-latest-7.noarch.rpm && yum update -y && yum -y install rsyslog nginx openssh-server && yum clean all && /usr/bin/ssh-keygen -A && sed -ri 's/\$ModLoad imjournal/\#\$ModLoad imjournal/g' /etc/rsyslog.conf && sed -ri 's/\$OmitLocalLogging on/\$OmitLocalLogging off/g' /etc/rsyslog.conf && sed -ri 's/\$IMJournalStateFile imjournal.state/\#\$IMJournalStateFile imjournal.state/g' /etc/rsyslog.conf && sed -ri 's/\$SystemLogSocketName/\#\$SystemLogSocketName/g' /etc/rsyslog.d/listen.conf
COPY logentries.conf /etc/rsyslog.d/logentries.conf

COPY run.sh /run.sh
RUN chmod 755 /run.sh
ENTRYPOINT /run.sh

EXPOSE 22 80

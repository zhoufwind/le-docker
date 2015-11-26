FROM dockerhub.hjidc.com/centos:7

MAINTAINER Feng Zhou <zhoufeng@hujiang.com>

RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo Asia/Shanghai > /etc/timezone

RUN mkdir -p /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys

RUN yum update -y
RUN yum -y install rsyslog
RUN yum clean all
RUN sed -ri 's/\$ModLoad imjournal/\#\$ModLoad imjournal/g' /etc/rsyslog.conf
RUN sed -ri 's/\$OmitLocalLogging on/\$OmitLocalLogging off/g' /etc/rsyslog.conf
RUN sed -ri 's/\$IMJournalStateFile imjournal.state/\#\$IMJournalStateFile imjournal.state/g' /etc/rsyslog.conf
RUN sed -ri 's/\$SystemLogSocketName/\#\$SystemLogSocketName/g' /etc/rsyslog.d/listen.conf
COPY logentries.conf /etc/rsyslog.d/logentries.conf

COPY run.sh /run.sh
RUN chmod 755 /run.sh
ENTRYPOINT /run.sh

EXPOSE 22

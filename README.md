le-docker
=========

Logentries/Docker integration examples

rsyslog
===

Usage:

From the root of the repository:

    $ docker build -t dockerhub.hjidc.com/le-docker:x.x .
    $ docker run -d -p 666:22 -p 777:80 dockerhub.hjidc.com/le-docker:x.x

Check Docker Process:

    $ # docker ps
    CONTAINER ID        IMAGE                                    COMMAND                CREATED             STATUS              PORTS                                          NAMES
    f2ad6876ca82        dockerhub.hjidc.com/le-docker:1.7        "/bin/sh -c /run.sh"   4 seconds ago       Up 3 seconds        0.0.0.0:666->22/tcp, 0.0.0.0:777->80/tcp       silly_elion                   

+++

Remote SSH login Container:

    $ ssh -p 666 localhost

SSH Login Log:

    Nov 26 21:21:12 TOKEN f2ad6876ca82 sshd[37]: Accepted publickey for root from 172.17.42.1 port 39768 ssh2: RSA a1:27:0f:4e:ed:4e:1b:84:44:ae:06:19:c5:a5:10:eb
    Nov 26 21:21:12 TOKEN f2ad6876ca82 sshd[37]: pam_unix(sshd:session): session opened for user root by (uid=0)
    Nov 26 21:21:12 TOKEN f2ad6876ca82 sshd[37]: pam_lastlog(sshd:session): unable to open /var/log/btmp: No such file or directory

+++

And to log some data:

    # logger 'hello, world!'

Logger Log:

    Nov 26 21:26:13 TOKEN f2ad6876ca82 root: hello, world!

+++

SSH Logoff Log:

    Nov 26 21:21:21 TOKEN f2ad6876ca82 sshd[37]: syslogin_perform_logout: logout() returned an error
    Nov 26 21:21:21 TOKEN f2ad6876ca82 sshd[37]: Received disconnect from 172.17.42.1: 11: disconnected by user
    Nov 26 21:21:21 TOKEN f2ad6876ca82 sshd[37]: pam_unix(sshd:session): session closed for user root

+++

Check Nginx Log:

    $ curl http://localhost:777/

Nginx Access Log:

    Nov 26 21:21:41 TOKEN f2ad6876ca82 kibana-nginx-accesslog:172.17.42.1 - - [26/Nov/2015:21:20:43 +0800] "GET / HTTP/1.1" 200 3700 "-" "curl/7.29.0" "-"

Refer
===

Running Syslog Within a Docker Container
 - http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/

How To Run Rsyslog in a Docker Container for Logging
 - https://blog.logentries.com/2014/03/how-to-run-rsyslog-in-a-docker-container-for-logging/

How to manager Docker log?
 - http://www.dockone.io/question/584

Logging Docker Container Output to journald
 - http://www.projectatomic.io/blog/2015/04/logging-docker-container-output-to-journald/

Rsyslog Deployment
 - http://my.oschina.net/duxuefeng/blog/317570

Rsyslog collecting Nginx Access log, which using Logstash as Shipper
 - http://www.tuicool.com/articles/V7jyq2e

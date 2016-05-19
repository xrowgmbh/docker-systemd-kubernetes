# docker build --rm --no-cache  -f files/docker/systemd/Dockerfile -t systemd /root/provision

FROM xrowgmbh/systemd

MAINTAINER "Björn Dieding" <bjoern@xrow.de>

ENV container=docker

RUN yum -y install php
ADD env2host.service /etc/systemd/system/env2host.service
RUN chmod 755 /etc/systemd/system/env2host.service
ADD env2host.php /usr/local/bin/env2host.php
RUN chmod 755 /usr/local/bin/env2host.php
RUN systemctl enable env2host.service

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]

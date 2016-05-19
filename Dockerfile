# docker build --rm --no-cache -t systemd-kubernetes .
# docker run --privileged --name systemd-kubernetes -e "KUBE_MASTER=192.168.255.4" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d systemd-kubernetes
# docker run --privileged --name systemd-kubernetes -e "KUBE_MASTER=192.168.255.4" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -ti systemd-kubernetes
# docker run --privileged --name systemd-kubernetes -e "KUBE_MASTER=192.168.255.4" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -ti systemd-kubernetes
# docker exec -it systemd-kubernetes /usr/bin/bash    
FROM xrowgmbh/systemd

MAINTAINER "Björn Dieding" <bjoern@xrow.de>

ENV container=docker

RUN yum -y install php-cli
ADD system.conf /etc/systemd/system.conf
ADD envsave.service /etc/systemd/system/envsave.service
RUN chmod 664 /etc/systemd/system/envsave.service
ADD env2host.service /etc/systemd/system/env2host.service
RUN chmod 664 /etc/systemd/system/env2host.service
ADD env2host.php /usr/local/bin/env2host.php
RUN chmod 755 /usr/local/bin/env2host.php
RUN systemctl enable env2host.service
RUN systemctl enable envsave.service

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]

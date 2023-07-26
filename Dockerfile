FROM centos:centos7.9.2009
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;


RUN rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub; \
    (curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo |  tee /etc/yum.repos.d/salt.repo); \
    yum clean expire-cache; \
    yum -y install salt-master; \
    yum -y install salt-minion; \
    yum -y install salt-ssh; \
    yum -y install salt-syndic; \
    yum -y install salt-cloud; \
    yum -y install salt-api;

RUN echo "id: rebel_1" > /etc/salt/minion.d/id.conf
RUN echo "master: 127.0.0.1" >  /etc/salt/minion.d/master.conf

EXPOSE 8080
EXPOSE 4505
EXPOSE 4506


VOLUME [ "/sys/fs/cgroup" ]
COPY ./start /opt/start.sh
RUN chmod a+x /opt/start.sh
COPY ./setup /opt/setup.sh
RUN chmod a+x /opt/setup.sh

CMD ["/opt/start.sh"]

FROM centos:7

ADD ./FirebirdCS-2.5.5.evo-7211.amd64.tar.gz /tmp/

COPY ./scripts/install.sh /tmp/FirebirdCS-2.5.5.evo/
COPY ./scripts/launch.sh /tmp/
COPY ./scripts/postinstall.sh /tmp/FirebirdCS-2.5.5.evo/scripts/
COPY ./scripts/changeMultiConnectMode.sh /tmp/FirebirdCS-2.5.5.evo/scripts/

RUN chmod +x /tmp/launch.sh && chmod +x /tmp/FirebirdCS-2.5.5.evo/install.sh && chmod +x /tmp/FirebirdCS-2.5.5.evo/scripts/postinstall.sh && yum install -y compat-libstdc++-33 wget xinetd bzip2 zip unzip patch ntp ntpdate lsof net-tools psmisc
RUN cd /tmp/FirebirdCS-2.5.5.evo && /tmp/FirebirdCS-2.5.5.evo/install.sh -silent

EXPOSE 3050/tcp

CMD [ "xinetd", "-dontfork" ]
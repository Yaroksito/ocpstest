# iPerf3 on RHEL-7 dockerfile
# Version 2
# Pull the rhel image from the local registry
    FROM registry.access.redhat.com/rhel 
# change the registry and the image for disconected env
    MAINTAINER "ypery@redhat.com"
    USER root
# Update image
#RUN yum repolist --disablerepo=* && \
#    yum-config-manager --disable \* > /dev/null && \
#    yum-config-manager --enable rhel-7-server-rpms > /dev/null && \
# local install iperf3 
RUN mkdir /install
COPY . /install
RUN chmod +x /install/iperf3-run.sh
RUN rpm -ivh /install/iperf3-3.1.3-1.fc24.x86_64.rpm && echo iperf3.rhel.ocp.rhevdemo.com > /etc/hostname
RUN rpm -ivh /install/libpcap-1.5.3-11.el7.x86_64.rpm
RUN rpm -ivh /install/nmap*
RUN /install/iperf3-run.sh 
#RUN rpm -ivh /install/iperf3-3.1.3-1.fc24.x86_64.rpm && echo iperf3.rhel.ocp.rhevdemo.com > /etc/hostname
#CMD iperf3 -c $RECURSIVE $SERVER_IP" > out
EXPOSE 5001/tcp


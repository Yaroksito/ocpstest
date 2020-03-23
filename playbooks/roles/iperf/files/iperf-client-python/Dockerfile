FROM centos:8
MAINTAINER Michael Greenberg

RUN  useradd iperf && yum update -y && yum install -y iperf3 python3 && yum clean all
USER iperf
COPY iperfcon.py /home/iperf/

EXPOSE 8080

CMD ["python3", "/home/iperf/iperfcon.py"]

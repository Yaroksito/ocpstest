FROM quay.io/ypery/ose-ansible-container
MAINTAINER Yaron Perry

RUN mkdir /root/playbooks
ADD playbooks /root/playbooks

# pull the quay.io/ypery/ose-ansible-container and add the playbooks dir to /root in order to run playbooks on sanity container
# tag it as ocpsanity:v1.5 and higher

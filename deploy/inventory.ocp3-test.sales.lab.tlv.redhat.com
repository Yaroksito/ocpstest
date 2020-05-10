[all:vars]
#################
#### Ansible Vars
#################
ansible_ssh_user=core
ansible_become=true
timeout=60
#searchdomain=ocp3.rhevdemo.com
#dns=["10.35.76.222","8.8.8.8"]
#keepalived_vip=10.35.76.220
#keepalived_interface=eth0
#keepalived_vrrpid=1
#routervialb=true


###################
##### sanity tests
###################
ocpappsdomain=apps.ocp43-test.sales.lab.tlv.redhat.com
openshift_console_api=apps.ocp43-test.sales.lab.tlv.redhat.com
localregistry="docker.io/nginx:latest"
#insecure=True
testproject=sanity-test
storageclass=rook-ceph-block
etcdSkip=True
ocpversion=4

#####################
##### OpenShift Hosts
#####################
[masters]
master-0.ocp43-test.sales.lab.tlv.redhat.com
master-1.ocp43-test.sales.lab.tlv.redhat.com
master-2.ocp43-test.sales.lab.tlv.redhat.com

[etcd:children]
masters

[nodes]
worker-1.ocp43-test.sales.lab.tlv.redhat.com
worker-2.ocp43-test.sales.lab.tlv.redhat.com
worker-3.ocp43-test.sales.lab.tlv.redhat.com
master-0.ocp43-test.sales.lab.tlv.redhat.com
master-1.ocp43-test.sales.lab.tlv.redhat.com
master-2.ocp43-test.sales.lab.tlv.redhat.com

[nodes:children]
masters

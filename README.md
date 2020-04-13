# ocpsanitytests
It consist of 3 automation tests to ensure that OCP 3.x / OCP 4.x clustes is ready:
- OpenShift cluster general functionality - it pulls nginx image and creates appliction on specific namespace, test the svc, route and PVC as well as DNS and registry. 
- OpenShift certificate expiration check - it inspects the expiration route and api OCP certificate and output message accordingelly 
- OpenShift SDN throughput test - it deploys 2 antiafinity iperf3 server & client pods and test the SDN throughput between them. It also provides Warnning or Critical message according to the trashhold.



Prerequisites

OCP 4.x/3.x cluster

Install oc client

The following image must be available on a local/remote insecure repository as follows:

    <registryIP:Port>/openshift3/nginx:latest


Summary

Project contains the following roles at present:

create_project

Performs the following tasks:
- create project
- create persistent storage claim
- deploy nginx with persistent storage
- checks that pods are up nginx answers via router
- tears down the project

infra_check

Checks the following tasks:
- pods are running in the main OCP projects
- checks for failed pods in all projects in the cluster
- router
- node status 
- etcd health
- console health

restart_nodes

Performs the following for each node in the cluster:
- checks selinux policy is correct
- marks node as unschedulable
- reboots node 
- checks node rejoins the cluster and is ready
- marks node as schedulable


Once all roles have run, there is a 5 minute delay and then a check is run to see all pods are running

Additional Parameters:

The following parameters are needed to run the tests, in addition to a valid OCP inventory file for the environment (the one used to deploy)

	ocpappsdomain: <openshift application subdomain>
	openshift_console_api: <master API FQDN and Port>
	localregistry: <registry where nginx image >
	testproject: <name of temporary project created for test app>  - default value is "scoobydoo"
    storageclass: <persistent storage class type> - default is "glusterfs-storage" (optional)

For OCP 4:

Copy kubeconfig file to base directory of this repo

Add the following 2 parameters for running with OCP 4

	etcdSkip=True
	ocpversion=4

Run playbook sanitytests_ocp4.yaml

NOTE:  when running on ocp 4 the following steps are skipped - etcd tests, reboot of nodes, selinux check on nodes


For the certificate expiration test:
Please provide your OCP url as the value for the keys "routerfqdn" "masterapifqdn"
in roles/cer_exp/defaults/main.yml file

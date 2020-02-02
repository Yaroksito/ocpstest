#!/bin/bash -x
nowdate=`date +"%Y%m%d" -d "+14 days + 2 year"`
ocpdate=`curl --insecure -v https://console-openshift-console.apps.ocp42.sales.lab.tlv.redhat.com 2>&1 | grep expire | awk '{print $4,$5,$6,$7}'`
ocpstring=`date -d "${ocpdate}" "+%Y%m%d"`
 [[ $ocpstring < $nowdate ]]
echo $?


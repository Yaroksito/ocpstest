#!/bin/bash -x
twoweeks=`date +"%Y%m%d" -d "+14 days +2 years"`
certexpd=`curl --insecure -v https://console-openshift-console.apps.ocp42.sales.lab.tlv.redhat.com 2>&1 | grep expire | awk '{print $4,$5,$6,$7}'`
certstrig=`date -d "${certexpd}" "+%Y%m%d"`
if [[ $certstrig > $twoweeks ]]; then

                echo "cert expired"
        else
                echo "cert OK"
        fi


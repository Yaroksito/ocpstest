#!/bin/bash -x
nowdate=`date '+%d%m%Y' -d "+14 days"`
ocpdate=`curl --insecure -v https://console-openshift-console.apps.ocp42.sales.lab.tlv.redhat.com 2>&1 | grep expire | awk '{print $4,$5,$6,$7}'` 
ocpstring=`date -d "${ocpdate}" "+%d%m%Y"`
if [[ $ocpstring > $nowdate ]]; then

		echo "cert expired"
	else
		echo "cert OK"
        fi

#for cert in `curl --insecure -v https://console-openshift-console.apps.ocp42.sales.lab.tlv.redhat.com 2>&1 | grep expire | awk '{print $4,$5,$6,$7}' | date +"%d%m%Y"`; do 
#        if [[ $cert > $now ]]; then
#                echo "cert expire"
#        else
#                echo "cert OK"
#        fi
#done










#`openssl x509 -subject -in /etc/pki/ca-trust/source/anchors/*crt -text | grep -i 'after' | awk '{print  $5 $4 $7}' | date +"%d%m%Y"`; do 
#	if [[ $cert > -gt $now ]]; then
#		echo "cert expire"
#	else
#		echo "cert OK"
#	fi
#done



#for cert in `openssl x509 -subject -in /etc/pki/ca-trust/source/anchors/*crt -text | grep -i 'after' | awk '{print  $5 $4 $7}'`; do date -d$cert +%Y%m%d; done

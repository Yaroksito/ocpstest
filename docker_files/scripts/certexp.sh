#!/bin/bash -x
now=$(date +"%d%m%Y")
for cert in `openssl x509 -subject -in /etc/pki/ca-trust/source/anchors/*crt -text | grep -i 'after' | awk '{print  $5 $4 $7}' | date +"%d%m%Y"`; do 
	if [[ $cert > -gt $now ]]; then
		echo "cert expire"
	else
		echo "cert OK"
	fi
done



#for cert in `openssl x509 -subject -in /etc/pki/ca-trust/source/anchors/*crt -text | grep -i 'after' | awk '{print  $5 $4 $7}'`; do date -d$cert +%Y%m%d; done

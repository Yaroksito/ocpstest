oc get projects |grep Terminating |awk '{print $1}' > mylist

filename='mylist'
while read p; do
    echo $p
    oc get namespace $p -o json |grep -v "kubernetes" > $p.json
done < $filename


#!/bin/bash
filename='mylist'
while read p; do
    curl -k -H "Content-Type: application/json" -X PUT --data-binary @$p.json localhost:8080/api/v1/namespaces/$p/finalize;
done < $filename

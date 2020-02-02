#!/bin/bash
# run bash script that defines  
#IPERF_TYPE - c/s
#IPERF_PORT - 5001
#IPERF_PROTOCOL_T tcp
#IPERF_PROTOCOL_u udp
#IPERF_FLAG
rm -f out
mkfifo out
trap "rm -f out" EXIT
while true
do
  cat out | nc -l 8080 > >( # parse the netcat output, to build the answer redirected to the pipe "out".
    export REQUEST=
    while read line
    do
      line=$(echo "$line" | tr -d '[\r\n]')
      if echo "$line" | grep -qE '^GET /' # if line starts with "GET /"
      then
        REQUEST=$(echo "$line" | cut -d ' ' -f2) # extract the request
      elif [ "x$line" = x ] # empty line / end of request
      then
        HTTP_200="HTTP/1.1 200 OK"
        HTTP_LOCATION="Location:"
        HTTP_404="HTTP/1.1 404 Not Found"
        # call a script here
        # Note: REQUEST is exported, so the script can parse it (to answer 200/403/404 status code + content)
        if echo $REQUEST | grep -qE '^/echo/'
        then
            printf "%s\n%s %s\n\n%s\n" "$HTTP_200" "$HTTP_LOCATION" $REQUEST ${REQUEST#"/echo/"} > out
        elif echo $REQUEST | grep -qE '^/iperf3'
        then
            QUERY_STRING=`echo $REQUEST | awk -F\? '{print $2}'`
	    IFS=','
            read -ra ADDR <<< "$QUERY_STRING"
            for i in "${ADDR[@]}"; do # access each element of
		if [[ $i =~ 'server' ]]; then
			SERVER_IP=`echo $i | awk -F\= '{print $2}'`
		elif [[ $i =~ 'recursive=yes' ]]; then
			RECURSIVE='-d'
		fi
	    done
	    echo "iperf3 -c $RECURSIVE $SERVER_IP" > out
	    IFS=' ' # reset to default value after usage
            #iperf3 -c -r  > out
            REQUEST=''
        else
            printf "%s\n%s %s\n\n%s\n" "$HTTP_404" "$HTTP_LOCATION" $REQUEST "Resource $REQUEST NOT FOUND!" > out
        fi
      fi
    done
  )
done


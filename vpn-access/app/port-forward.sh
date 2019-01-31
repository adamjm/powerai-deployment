#!/bin/bash
JUPYTER_REMOTE_PORT=$1
SSH_REMOTE_PORT=$2
echo $JUPYTER_REMOTE_PORT
iptables -t nat -A PREROUTING -p tcp --dport 35455 -j DNAT --to-destination 172.23.19.126:$JUPYTER_REMOTE_PORT
iptables -t nat -A PREROUTING -p tcp --dport 35454 -j DNAT --to-destination 172.23.19.126:$SSH_REMOTE_PORT
iptables -t nat -A POSTROUTING -j MASQUERADE
#redir --laddr=0.0.0.0 --lport=35454 --caddr=172.23.19.126 --cport=$PORT
echo $PASSWORD | openconnect --user $USER https://spcaus.spc.ibm.com/ --servercert $CERT --passwd-on-stdin
#sha256:70c92774ac7dd8bf76403794ebe35d7937723397dc413e7debba358d7521c450
sleep 5
#ssh -D 35453 -q -C -N 172.23.19.126 -p $PORT
echo "Redirecting traffic"


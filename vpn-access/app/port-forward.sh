#!/bin/bash
JUPYTER_REMOTE_PORT=$1
SSH_REMOTE_PORT=$2
TB_REMOTE_PORT=$3
echo $JUPYTER_REMOTE_PORT
iptables -t nat -A PREROUTING -p tcp --dport 35555 -j DNAT --to-destination 172.23.19.126:$JUPYTER_REMOTE_PORT
iptables -t nat -A PREROUTING -p tcp --dport 35553 -j DNAT --to-destination 172.23.19.126:$TB_REMOTE_PORT
iptables -t nat -A PREROUTING -p tcp --dport 35554 -j DNAT --to-destination 172.23.19.126:$SSH_REMOTE_PORT
iptables -t nat -A POSTROUTING -j MASQUERADE
#redir --laddr=0.0.0.0 --lport=35454 --caddr=172.23.19.126 --cport=$PORT
echo $PASSWORD | openconnect --user $USER https://spcaus.spc.ibm.com/  --passwd-on-stdin --authenticate &> /tmp/cert.txt
CERT=`grep servercert /tmp/cert.txt | awk '{print $2}'`
rm /tmp/cert.txt
echo 'Cert '$CERT''
echo $PASSWORD | openconnect --user $USER https://spcaus.spc.ibm.com/ --servercert $CERT --passwd-on-stdin


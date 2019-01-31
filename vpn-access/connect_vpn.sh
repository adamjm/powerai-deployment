#!/bin/bash
## to connect to the vpn simply run the following command:
## ./connect_vpn.sh <ssh_port> <jupyter_port> <tensorboard_port> <username> <password>
## you may need to run with sudo permissions if docker requires sudo to run
## jupyter will be accessible from http://localhost:35555
## ssh access will be accessible via ssh root@0.0.0.0 -p 35554
## tensorboard will be accessible via http://localhost:35553

SSH_PORT=$1
JUPYTER_PORT=$2
TB_PORT=$3
USER=$4
PASSWORD=$5

docker build -f Dockerfile -t ibmvpn:v0.1 .
docker run --cap-add NET_ADMIN -e PASSWORD=$PASSWORD -e USER=$USER -p 35555:35555 -p 35554:35554 -p 35553:35553 -it ibmvpn:v0.1 $JUPYTER_PORT $SSH_PORT $TB_PORT

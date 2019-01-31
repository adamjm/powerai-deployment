# Connect to the Sydney Lab VPN

## How to connect
To connect run the following command:

`./connect_vpn.sh <ssh_port> <jupyter_port> <tensorboard_port> <username> <password>`

NOTE: You may need to run with sudo permissions if docker requires sudo to run

## How to access the environments

- Jupyter will be accessible from http://localhost:35555
- ssh access will be accessible via ssh root@0.0.0.0 -p 35554
- Tensorboard will be accessible via http://localhost:35553

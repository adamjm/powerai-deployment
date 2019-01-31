FROM ubuntu:18.04
RUN apt-get update && apt-get install -y openconnect network-manager-openconnect ssh redir
COPY app /app
WORKDIR /app
RUN chmod +x port-forward.sh
CMD  ["/app/port-forward.sh"]
#echo $PASSWORD | openconnect --user $USER spcaus.spc.ibm.com --servercert $CERT --passwd-on-stdin

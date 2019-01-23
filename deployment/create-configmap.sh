#!/bin/bash
array=$1
for i in "${array[@]}"
do
   echo $i >> /tmp/authorized_keys
done
kubectl create configmap ssh-keys --from-file=authorized_keys=/tmp/authorized_keys
rm /tmp/authorized_keys

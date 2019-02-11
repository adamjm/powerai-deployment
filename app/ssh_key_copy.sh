#!/bin/bash
echo $SSH_KEY >> /root/.ssh/authorized_keys
echo $SSH_KEY >> /home/pwrai/.ssh/authorized_keys

IBM_POWERAI_LICENSE_ACCEPT=yes /opt/DL/license/bin/accept-powerai-license.sh

echo "source /opt/DL/tensorflow/bin/tensorflow-activate" >> /root/.bashrc
echo "source /opt/DL/tensorflow/bin/tensorflow-activate" >> /home/pwrai/.bashrc
echo "source /opt/DL/pytorch/bin/pytorch-activate" >> /root/.bashrc
echo "source /opt/DL/pytorch/bin/pytorch-activate" >> /home/pwrai/.bashrc
echo "source /opt/DL/caffe/bin/caffe-activate" >> /root/.bashrc
echo "source /opt/DL/caffe/bin/caffe-activate" >> /home/pwrai/.bashrc

PATH=$PATH:/home/pwrai/anaconda3/bin
source /opt/DL/tensorflow/bin/tensorflow-activate
source /opt/DL/pytorch/bin/pytorch-activate
source /opt/DL/caffe/bin/caffe-activate

#service ssh restart
/usr/sbin/sshd -D & 
#/opt/anaconda3/bin/conda install keras -y
source /root/.bashrc
pip install -e git+https://github.com/adamjm/autokeras.git#egg=autokeras
python -m ipykernel install --name powerai --display-name "powerai"

echo $PATH
echo $PYTHONPATH
echo $LD_LIBRARY_PATH
env PATH=$PATH PYTHONPATH=$PYTHONPATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH PASSWORD=$PASSWORD jupyter lab --no-browser --allow-root --port=8888 --ip=0.0.0.0 --config=/root/.jupyter/jupyter_notebook_config.py

#tail -f /dev/null

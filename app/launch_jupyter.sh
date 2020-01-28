#!/bin/bash
IBM_POWERAI_LICENSE_ACCEPT=yes /opt/DL/license/bin/accept-powerai-license.sh

#/opt/anaconda3/bin/conda install keras -y

echo $PATH
echo $PYTHONPATH
echo $LD_LIBRARY_PATH
eval "$(conda shell.bash hook |sed 's/base/wmlce/g')"
env PATH=$PATH PYTHONPATH=$PYTHONPATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
#tail -f /dev/null

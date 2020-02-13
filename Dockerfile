FROM ibmcom/powerai:1.6.2-all-ubuntu18.04-py37
COPY app /app
WORKDIR /app
USER root
RUN mkdir -p /root/.jupyter && cp jupyter_notebook_config.py /root/.jupyter/ 
RUN apt-get update && apt-get install -y gnupg git vim cmake gfortran wget 

ARG PATH=/opt/anaconda/bin/:$PATH
ENV PATH=/opt/anaconda/bin/:$PATH

ARG LICENSE=yes
ENV LICENSE=yes

SHELL ["/bin/bash", "-c"]

RUN cp /usr/bin/make /usr/bin/make.orig && echo "#!/bin/bash" >> /usr/bin/make && echo  "make -j 128 $1" >> /usr/bin/make && chmod +x /usr/bin/make

RUN /opt/anaconda/bin/conda install -n wmlce -y hdf5 scipy
RUN /opt/anaconda/bin/conda install -n wmlce -y pandas matplotlib
#RUN /opt/anaconda/bin/conda install -n wmlce -c numba -y llvmlite cython
RUN /opt/anaconda/bin/conda install -n wmlce nodejs jupyterlab 
RUN /opt/anaconda/bin/conda install -n wmlce cudatoolkit

RUN cp /app/health-check-gpu /usr/bin/ && chmod +x /usr/bin/health-check-gpu
CMD ["/bin/bash", "/app/launch_jupyter.sh"]

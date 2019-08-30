FROM ibmcom/powerai:1.6.1-all-ubuntu18.04-py3
COPY app /app
WORKDIR /app
USER root
RUN mkdir /root/.ssh
RUN mkdir -p /root/.jupyter && cp jupyter_notebook_config.py /root/.jupyter/ 
RUN chmod +x /app/ssh_key_copy.sh
RUN mkdir /run/sshd && mkdir /notebooks
COPY llvm-alternatives/llvm-alternatives /app
#RUN /opt/anaconda3/bin/conda install -c conda-forge jupyterlab
RUN apt-get update && apt-get install -y gnupg
RUN apt-get update && apt-get install -y git vim cmake gfortran wget &&  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - && apt-get update && apt-get install -y libllvm-7-ocaml-dev libllvm7 llvm-7 llvm-7-dev llvm-7-doc llvm-7-examples llvm-7-runtime g++ gcc
ARG PATH=/opt/anaconda3/bin/:$PATH
ENV PATH=/opt/anaconda3/bin/:$PATH
ARG LICENSE=yes
ENV LICENSE=yes
SHELL ["/bin/bash", "-c"]
RUN cp /usr/bin/make /usr/bin/make.orig && echo "#!/bin/bash" >> /usr/bin/make && echo  "make -j 128 $1" >> /usr/bin/make && chmod +x /usr/bin/make 
RUN /opt/anaconda3/bin/conda install -y pandas matplotlib && \
   /opt/anaconda3/bin/conda install -c numba -y llvmlite cython
RUN /opt/anaconda3/bin/pip install nodejs jupyterlab keras
RUN /opt/anaconda3/bin/conda install cudatoolkit-dev
RUN cp /app/health-check-gpu /usr/bin/ && chmod +x /usr/bin/health-check-gpu
CMD ["/bin/bash", "/app/ssh_key_copy.sh"]

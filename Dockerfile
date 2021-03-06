FROM ibmcom/powerai:1.5.4-all-ubuntu18.04-py3
COPY app /app
WORKDIR /app
USER root
RUN mkdir /root/.ssh && mkdir /home/pwrai/.ssh
RUN mkdir -p /root/.jupyter && mkdir -p /home/pwrai/.jupyter && cp jupyter_notebook_config.py /root/.jupyter/ && cp jupyter_notebook_config.py /home/pwrai/.jupyter/
RUN chmod +x /app/ssh_key_copy.sh
RUN mkdir /run/sshd && mkdir /notebooks
COPY llvm-alternatives/llvm-alternatives /app
#RUN /opt/anaconda3/bin/conda install -c conda-forge jupyterlab
RUN apt-get update && apt-get install -y git vim cmake gfortran wget &&  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - && apt-get update && apt-get install -y libllvm-7-ocaml-dev libllvm7 llvm-7 llvm-7-dev llvm-7-doc llvm-7-examples llvm-7-runtime
ARG PATH=/opt/anaconda3/bin/:$PATH
ENV PATH=/opt/anaconda3/bin/:$PATH
ARG LICENSE=yes
ENV LICENSE=yes
SHELL ["/bin/bash", "-c"]
RUN cp /usr/bin/make /usr/bin/make.orig && echo "#!/bin/bash" >> /usr/bin/make && echo  "make -j 128 $1" >> /usr/bin/make && chmod +x /usr/bin/make 
RUN echo "Status=9" > /opt/DL/license/lap_se/license/status.dat
RUN  source /opt/DL/tensorflow/bin/tensorflow-activate &&  \
    source /opt/DL/pytorch/bin/pytorch-activate && \
   /opt/anaconda3/bin/conda install -y llvmlite pandas matplotlib && \
 /opt/anaconda3/bin/pip install -e git+https://github.com/adamjm/autokeras.git#egg=autokeras
#RUN git clone https://github.com/Qiskit/qiskit-aer.git && cd qiskit-aer/ && pip install scikit-build &&  pip install -U -r requirements-dev.txt && python ./setup.py bdist_wheel -- -j8 && cd dist && pip install qiskit_aer*.whl
RUN /opt/anaconda3/bin/pip install nodejs jupyterlab keras
#RUN /opt/anaconda3/bin/conda upgrade sympy --no-deps && pip install qiskit
CMD ["/bin/bash", "/app/ssh_key_copy.sh"]

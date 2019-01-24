FROM ibmcom/powerai:1.5.4-all-ubuntu18.04-py3
COPY app /app
WORKDIR /app
USER root
RUN mkdir /root/.ssh && mkdir /home/pwrai/.ssh
RUN mkdir -p /root/.jupyter && mkdir -p /home/pwrai/.jupyter && cp jupyter_notebook_config.py /root/.jupyter/ && cp jupyter_notebook_config.py /home/pwrai/.jupyter/
RUN chmod +x /app/ssh_key_copy.sh
RUN mkdir /run/sshd && mkdir /notebooks
#RUN /opt/anaconda3/bin/conda install -c conda-forge jupyterlab
RUN apt-get update && apt-get install -y git vim 
ARG PATH=/opt/anaconda3/bin/:$PATH
ENV PATH=/opt/anaconda3/bin/:$PATH
RUN /opt/anaconda3/bin/pip install nodejs jupyterlab
CMD ["/bin/bash", "/app/ssh_key_copy.sh"]

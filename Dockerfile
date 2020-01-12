FROM powerai/powerai-jupyter:1.6.1

RUN apt-get update && apt-get install -y pkg-config

# Steps to install Spacy
RUN mkdir /sentencepiece/ && git clone https://github.com/google/sentencepiece.git /sentencepiece && cd /sentencepiece/ && mkdir build && \
cd build && cmake .. && make -j 68 && make install && ldconfig -v && cd ../python && python setup.py build && python setup.py install

RUN apt-get update && apt-get install -y autoconf
ARG BLIS_ARCH=power9
ENV BLIS_ARCH=power9
RUN mkdir /cython-blis && git clone --recursive https://github.com/explosion/cython-blis.git /cython-blis && cd /cython-blis && pip install -r dev-requirements.txt && ./bin/generate-make-jsonl linux power9 && python setup.py build_ext --inplace && python setup.py bdist_wheel && python setup.py install
#git clone https://github.com/flame/blis.git /blis && cd /blis && ./configure power9 && make -j 64 && make install 
RUN pip install -e git+https://github.com/explosion/thinc_gpu_ops#egg=thinc_gpu_ops
RUN git clone https://github.com/explosion/cymem.git /cymem && cd /cymem && pip install -r requirements.txt && python setup.py build_ext --inplace && python setup.py bdist_wheel && pip install dist/*whl
RUN git clone https://github.com/adamjm/thinc /thinc && cd /thinc &&  pip install -r requirements.txt && python setup.py build_ext --inplace && python setup.py bdist_wheel && pip install dist/*whl
RUN cd / && git clone https://github.com/adamjm/spaCy /spacy && cd /spacy && mv include/numpy include/numpy.old && ln -s /opt/anaconda3/lib/python3.6/site-packages/numpy/core/include/numpy include/ && ls -ltr include/ && ls -ltr include/numpy/ && python setup.py build_ext --inplace && python setup.py bdist_wheel && pip install dist/*whl
RUN pip install fastai==1.0.51 tensorboardX==1.6 ffmpeg ffmpeg-python==0.1.17 youtube-dl>=2019.4.17
RUN pip install ludwig[text,viz]
CMD ["/bin/bash", "/app/ssh_key_copy.sh"]

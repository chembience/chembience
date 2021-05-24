ARG build_tag
FROM chembience/jupyter:$build_tag
ARG conda_py

LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

COPY nginx /home/nginx
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py pip install -r /requirements.txt
    #CONDA_PY=$CONDA_PY conda install --yes --file /requirements.txt
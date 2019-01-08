ARG build_tag
FROM chembience/rdkit-base:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_PY 37

RUN mkdir -p /opt/jupyter /home/nginx

COPY ./.env /opt/jupyter/env
COPY . /opt/jupyter
COPY ./app-context/nginx /home/nginx

COPY docker-entrypoint.sh /
COPY requirements.txt /

RUN CONDA_PY=$CONDA_PY conda config --add channels conda-forge && \
    /bin/bash -c "source activate chembience" && \
    CONDA_PY=$CONDA_PY conda install --yes --file /requirements.txt

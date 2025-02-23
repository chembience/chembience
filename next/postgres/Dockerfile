ARG conda_package=continuumio/miniconda3
ARG conda_tag=latest
FROM $conda_package:$conda_tag
ARG conda_py

LABEL maintainer="markussitzmann@gmail.com "

RUN apt-get --allow-releaseinfo-change update && \
    apt-get -y --no-install-recommends install gosu joe postgresql-client

RUN mkdir -p /home/postgres /opt/python
#COPY requirements.txt /opt/python

ENV PATH /opt/conda/bin:$PATH

#COPY requirements.txt /opt/python/
COPY docker-entrypoint.sh /

RUN CONDA_PY=$conda_py conda config --add channels conda-forge && \
    CONDA_PY=$conda_py conda create --verbose --yes -n chembience && \
    /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install -c conda-forge rdkit-postgresql && \
#    CONDA_PY=$conda_py /opt/conda/bin/pip install -r /opt/python/requirements.txt && \
    CONDA_PY=$conda_py conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete


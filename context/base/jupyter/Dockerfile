ARG build_label
FROM chembience/rdkit_base:$build_label
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/jupyter

COPY ./.env /opt/jupyter/env
COPY . /opt/jupyter

COPY docker-entrypoint.sh /
COPY requirements.txt /

RUN CONDA_PY=36 conda config --add channels conda-forge && \
    /bin/bash -c "source activate chembience" && \
    CONDA_PY=36 conda install --yes --file /requirements.txt

ARG build_tag
FROM chembience/python-base:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com"

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_PY 37
ENV RDKIT_VERSION 2019.09.3

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$CONDA_PY conda install cairo && \
    CONDA_PY=$CONDA_PY conda install -c rdkit rdkit=$RDKIT_VERSION && \
#    CONDA_PY=$CONDA_PY conda install -c rdkit/label/beta rdkit=$RDKIT_VERSION && \
    CONDA_PY=$CONDA_PY conda clean -pt

RUN mkdir -p /opt/rdkit

COPY ./.env /opt/rdkit/env
COPY . /opt/rdkit
COPY ./app-context /opt/rdkit/app-context

COPY docker-entrypoint.sh /




ARG build_tag
FROM chembience/python-base:$build_tag
ARG conda_py
ARG rdkit_version

LABEL maintainer="markus.sitzmann@gmail.com"

ENV PATH /opt/conda/bin:$PATH


RUN mkdir -p /opt/rdkit

ADD ./.env /opt/rdkit/env
ADD . /opt/rdkit
ADD ./app-context /opt/rdkit/app-context

ADD docker-entrypoint.sh /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install cairo && \
    CONDA_PY=$conda_py conda install -c rdkit rdkit=$rdkit_version && \
    CONDA_PY=$conda_py conda clean -pt

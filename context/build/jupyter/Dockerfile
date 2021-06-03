ARG build_tag
FROM chembience/rdkit-base:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/jupyter /home/nginx

COPY . /opt/jupyter
COPY ./.env /opt/jupyter/env
COPY ./app-context/nginx /home/nginx

COPY docker-entrypoint.sh /
COPY requirements.txt /opt/jupyter

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda config --add channels conda-forge && \
    CONDA_PY=$conda_py conda install --yes --file /opt/jupyter/requirements.txt

ARG build_tag
FROM chembience/rdkit-base:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com"

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/django /home/nginx

COPY ./.env /opt/django/env
COPY . /opt/django
COPY ./app-context/nginx /home/nginx

COPY docker-entrypoint.sh /
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda config --add channels conda-forge && \
    CONDA_PY=$conda_py conda install --yes --file /requirements.txt

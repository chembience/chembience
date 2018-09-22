ARG build_label
FROM chembience/rdkit-base:$build_label
LABEL maintainer="markus.sitzmann@gmail.com"

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/django /home/nginx

COPY ./.env /opt/django/env
COPY . /opt/django
COPY ./app-context/nginx /home/nginx

COPY docker-entrypoint.sh /
COPY requirements.txt /

RUN CONDA_PY=36 conda config --add channels conda-forge

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=36 conda install --yes --file /requirements.txt

ARG build_tag
FROM chembience/rdkit-base:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com"

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/django /home/nginx

ADD ./.env /opt/django/env
RUN true

ADD . /opt/django
RUN true

ADD ./app-context/nginx /home/nginx
RUN true

ADD docker-entrypoint.sh /
RUN true

ADD requirements.txt /
RUN true

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda config --add channels conda-forge && \
    CONDA_PY=$conda_py conda install --yes --file /requirements.txt

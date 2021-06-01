ARG build_tag
FROM chembience/rdkit-base:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/jupyter /home/nginx

COPY ./.env /opt/jupyter/env
#dirty bug fix
RUN true

COPY . /opt/jupyter
#dirty bug fix
RUN true

COPY ./app-context/nginx /home/nginx
#dirty bug fix
RUN true

COPY docker-entrypoint.sh /
#dirty bug fix
RUN true

ADD requirements.txt /
#dirty bug fix
RUN true

RUN CONDA_PY=$conda_py conda config --add channels conda-forge && \
    /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install --yes --file /requirements.txt

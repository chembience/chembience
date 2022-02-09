ARG build_tag
FROM chembience/base:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/jupyter /home/nginx

#COPY . /opt/jupyter
#COPY ./.env /opt/jupyter/env
#COPY ../../app/app-context/nginx /home/nginx

COPY docker-entrypoint.sh /
COPY requirements.txt /opt/jupyter

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install --freeze-installed --yes --file /opt/jupyter/requirements.txt && \
    conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete



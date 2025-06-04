ARG build_tag=latest
FROM chembience/rdkit:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com"

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN mkdir -p /home/template /opt/django

COPY docker-entrypoint.sh /
COPY docker-compose.yml /
COPY env /
COPY requirements.txt /opt/django
COPY template/* /home/template

ENV PATH=/opt/conda/bin:$PATH

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install --yes --file /opt/django/requirements.txt && \
    conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

WORKDIR /home/app

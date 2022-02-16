ARG build_tag
FROM chembience/base:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com"

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /home/nginx /opt/rdkit
COPY requirements.txt /opt/rdkit

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install --freeze-installed --yes --file /opt/rdkit/requirements.txt && \
    conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

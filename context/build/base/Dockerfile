FROM debian:bullseye-slim
LABEL maintainer="markus.sitzmann@gmail.com "
ARG conda_py
ARG conda_package
ARG rdkit_version
ARG cuid
ARG cgid

ENV PATH /opt/conda/bin:$PATH

RUN apt-get --allow-releaseinfo-change update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl wget gosu sudo unzip tar bzip2 git gnupg2 joe postgresql-client-13 libfontconfig1 libxrender1 	libxext6

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN cd /tmp && \
    git clone https://github.com/chembience/pychembience.git && \
    cp -r pychembience /opt && \
    rm -rf pychembience

RUN mkdir -p /opt/python
COPY requirements.txt /opt/python

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/$conda_package && \
    /bin/bash /$conda_package -b -p /opt/conda && \
    rm $conda_package && \
    CONDA_PY=$conda_py conda install --freeze-installed anaconda-client --yes && \
    CONDA_PY=$conda_py conda config --add channels conda-forge && \
    CONDA_PY=$conda_py conda create --verbose --yes -n chembience && \
    /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install pip && \
    CONDA_PY=$conda_py conda install --freeze-installed --yes --file /opt/python/requirements.txt && \
    CONDA_PY=$conda_py conda install cairo && \
    CONDA_PY=$conda_py conda install -c rdkit rdkit=$rdkit_version && \
    conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

ENTRYPOINT ["/docker-entrypoint.sh"]

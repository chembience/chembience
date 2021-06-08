ARG build_tag
FROM chembience/base:$build_tag
ARG conda_py
ARG conda_package

LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/python

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/$conda_package && \
    /bin/bash /$conda_package -b -p /opt/conda && \
    rm $conda_package

COPY requirements.txt /opt/python

RUN CONDA_PY=$conda_py conda install --freeze-installed anaconda-client --yes && \
    CONDA_PY=$conda_py conda config --add channels conda-forge && \
    CONDA_PY=$conda_py conda create --verbose --yes -n chembience

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install --freeze-installed --yes --file /opt/python/requirements.txt && \
    conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

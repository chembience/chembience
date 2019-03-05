ARG build_tag
FROM chembience/base:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_PY 37
ENV CONDA_PACKAGE Miniconda3-4.5.12-Linux-x86_64.sh

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/$CONDA_PACKAGE && \
    /bin/bash /$CONDA_PACKAGE -b -p /opt/conda && \
    rm $CONDA_PACKAGE

COPY requirements.txt /

RUN CONDA_PY=$CONDA_PY conda install anaconda-client --yes && \
    CONDA_PY=$CONDA_PY conda config --add channels conda-forge && \
    CONDA_PY=$CONDA_PY conda create --verbose --yes -n chembience

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$CONDA_PY conda install --yes --file /requirements.txt && \
    CONDA_PY=$CONDA_PY conda update --all

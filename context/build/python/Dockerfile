ARG build_label
FROM chembience/base:$build_label
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_PACKAGE Miniconda3-4.5.11-Linux-x86_64.sh


RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/$CONDA_PACKAGE && \
    /bin/bash /$CONDA_PACKAGE -b -p /opt/conda && \
    rm $CONDA_PACKAGE


COPY requirements.txt /

RUN CONDA_PY=37 conda install anaconda-client --yes && \
    CONDA_PY=37 conda config --add channels conda-forge && \
    CONDA_PY=37 conda create --verbose --yes -n chembience

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=37 conda install --yes --file /requirements.txt

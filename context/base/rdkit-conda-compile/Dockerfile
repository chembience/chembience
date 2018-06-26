FROM debian:stretch
LABEL maintainer="markussitzmann@gmail.com"

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl wget gosu sudo \
    gnupg \
    unzip tar bzip2 \
    git \
    build-essential \
#    postgresql-client \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    libcairo2-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    flex \
    bison \
    libfreetype6 \
    libfreetype6-dev \
    libtiff5-dev \
    libjpeg62-turbo-dev \
    libxml2-dev \
    libxslt1-dev \
    patch \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.5.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-4.5.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-4.5.1-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

RUN CONDA_PY=36 conda install anaconda-client --yes

RUN mkdir -p /home/rdkit
WORKDIR /home/rdkit

RUN git clone https://github.com/chembience/conda-rdkit.git
WORKDIR conda-rdkit
RUN git checkout chembience

ENV PATH /opt/conda/bin:$PATH

RUN CONDA_PY=36 conda install jinja2 conda-build --yes && \
    CONDA_PY=36 conda build boost --quiet --no-anaconda-upload && \
    CONDA_PY=36 conda build nox --quiet --no-anaconda-upload && \
    CONDA_PY=36 conda build cairo_nox --quiet --no-anaconda-upload && \
    CONDA_PY=36 conda build cairocffi --quiet --no-anaconda-upload && \
    CONDA_PY=36 conda build eigen --quiet --no-anaconda-upload && \
    CONDA_PY=36 CONDA_NPY=112 conda build rdkit --quiet --no-anaconda-upload
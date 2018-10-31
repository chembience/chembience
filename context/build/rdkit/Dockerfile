ARG build_label
FROM chembience/python-base:$build_label
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN apt-get -y --no-install-recommends install \
    libcairo2 \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
	flex \
	bison \
    libfreetype6 \
    && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=37 conda install cairo && \
    CONDA_PY=37 conda install cairocffi && \
    CONDA_PY=37 conda install -c conda-forge rdkit && \
    CONDA_PY=37 conda clean -pt

RUN mkdir -p /opt/rdkit

COPY ./.env /opt/rdkit/env
COPY . /opt/rdkit
COPY ./app-context /opt/rdkit/app-context

COPY docker-entrypoint.sh /




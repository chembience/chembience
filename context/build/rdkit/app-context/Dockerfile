ARG build_label
FROM chembience/rdkit:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /home/app:/opt/conda/bin:$PATH

COPY requirements.txt /

RUN CONDA_PY=36 conda config --add channels conda-forge

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=36 conda install --yes --file /requirements.txt
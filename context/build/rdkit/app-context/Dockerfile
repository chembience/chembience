ARG build_tag
FROM chembience/rdkit:$build_tag
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /home/app:/opt/conda/bin:$PATH
ENV CONDA_PY 37

COPY requirements.txt /

RUN CONDA_PY=$CONDA_PY  conda config --add channels conda-forge

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$CONDA_PY conda install --yes --file /requirements.txt
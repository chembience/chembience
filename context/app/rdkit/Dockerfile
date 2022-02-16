ARG build_tag
FROM chembience/rdkit:$build_tag
ARG conda_py

LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /home/app:/opt/conda/bin:$PATH

COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py /opt/conda/bin/pip install -r /requirements.txt


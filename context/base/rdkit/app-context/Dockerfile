ARG build_label
FROM chembience/rdkit:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /home/app:/opt/conda/bin:$PATH

COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    pip install -r /requirements.txt

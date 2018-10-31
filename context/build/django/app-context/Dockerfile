ARG build_label
FROM chembience/django:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

COPY nginx /home/nginx
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=37 conda install --yes --file requirements.txt

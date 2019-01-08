ARG build_tag
FROM chembience/jupyter:$build_tag
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

COPY nginx /home/nginx
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=36 conda install --yes --file /requirements.txt

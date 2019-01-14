ARG build_tag
FROM chembience/jupyter:$build_tag
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_PY 37

COPY nginx /home/nginx
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$CONDA_PY conda install --yes --file /requirements.txt

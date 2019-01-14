ARG build_tag
FROM chembience/django:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_PY 37

COPY nginx /home/nginx
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$CONDA_PY conda install --yes --file requirements.txt

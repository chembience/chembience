ARG build_label
FROM chembience/rdkit_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN mkdir -p /opt/django

COPY ./.env /opt/django/env
COPY . /opt/django

COPY docker-entrypoint.sh /
COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    pip install -r /requirements.txt

ARG build_label
FROM markussitzmann/chembience_django:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

COPY requirements.txt /

RUN /bin/bash -c "source activate chembience" && \
    pip install -r /requirements.txt

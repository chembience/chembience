ARG build_label
FROM chembience/rdkit_conda_compile:$build_label as rdkit-build
FROM chembience/python_base:$build_label
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN apt-get -y --no-install-recommends install \
    libcairo2 \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
	flex \
	bison \
    libfreetype6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=rdkit-build /opt/conda/conda-bld/linux-64/*.tar.bz2 /tmp/

#RUN /bin/bash -c "source activate chembience" && \
#    conda install --offline /tmp/boost-*.tar.bz2  && \
#    conda install --offline /tmp/cairo-*.tar.bz2 && \
#    conda install --offline /tmp/cairocffi-*.tar.bz2 && \
#    conda install --offline /tmp/eigen-*.tar.bz2  && \
#    conda install --offline /tmp/nox-*.tar.bz2  && \
#    conda install --offline /tmp/rdkit-*.tar.bz2 && \
#    conda clean -pt

RUN /bin/bash -c "source activate chembience" && \
    #conda install --offline /tmp/boost-*.tar.bz2  && \
    conda install cairo && \
    conda install cairocffi && \
    #conda install --offline /tmp/eigen-*.tar.bz2  && \
    #conda install --offline /tmp/nox-*.tar.bz2  && \
    conda install rdkit && \
    conda clean -pt

RUN mkdir -p /opt/rdkit

COPY ./.env /opt/rdkit/env
COPY . /opt/rdkit
COPY ./app-context /opt/rdkit/app-context

RUN rm -rf /tmp/*.tar.bz2

COPY docker-entrypoint.sh /




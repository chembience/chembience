ARG build_label
FROM markussitzmann/chembience_rdkit_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /home/chembience

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
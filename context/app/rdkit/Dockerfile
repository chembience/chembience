ARG build_label
FROM markussitzmann/chembience_rdkit_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH


ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
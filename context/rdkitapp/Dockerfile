ARG build_label
FROM markussitzmann/chembience_rdkit:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH


ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
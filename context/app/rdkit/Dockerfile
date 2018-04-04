ARG build_label
FROM markussitzmann/chembience_rdkit_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /home/app:/opt/conda/bin:$PATH

WORKDIR /home/app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
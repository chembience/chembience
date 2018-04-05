ARG build_label
FROM chembience/rdkit_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

#ENV PATH /home/app:/opt/conda/bin:$PATH

WORKDIR /home/app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
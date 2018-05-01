ARG build_label
FROM chembience/rdkit_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

WORKDIR /home/app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
ARG build_label
FROM chembience/rdkit-base:$build_label
LABEL maintainer="markus.sitzmann@gmail.com "

WORKDIR /home/app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
ARG build_tag
FROM chembience/rdkit-base:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com "

WORKDIR /home/app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
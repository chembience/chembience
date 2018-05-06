FROM debian:stretch
LABEL maintainer="markussitzmann@gmail.com "

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl wget gosu sudo \
    gnupg \
    unzip tar bzip2 \
    git \
    postgresql-client \
    joe
    
COPY docker-entrypoint.sh /
COPY ./chembience /opt/chembience

RUN cd /tmp \
    && git clone https://github.com/chembience/pychembience.git \
    && cp -r pychembience /opt \
    && rm -rf pychembience

ENTRYPOINT ["/docker-entrypoint.sh"]
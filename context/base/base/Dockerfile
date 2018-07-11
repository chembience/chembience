FROM debian:stretch
LABEL maintainer="markus.sitzmann@gmail.com "

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl wget gosu sudo unzip tar bzip2 git gnupg2


RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update && apt-get -y --no-install-recommends install \
    postgresql-client-10 \
    joe
    
COPY docker-entrypoint.sh /
COPY ./chembience /opt/chembience

RUN cd /tmp \
    && git clone https://github.com/chembience/pychembience.git \
    && cp -r pychembience /opt \
    && rm -rf pychembience

ENTRYPOINT ["/docker-entrypoint.sh"]
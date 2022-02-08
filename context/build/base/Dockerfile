FROM debian:bullseye-slim
LABEL maintainer="markus.sitzmann@gmail.com "

RUN apt-get --allow-releaseinfo-change update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl wget gosu sudo unzip tar bzip2 git gnupg2

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get --allow-releaseinfo-change update && apt-get -y --no-install-recommends install \
    postgresql-client-13 \
    joe

COPY . /opt/sphere
COPY ./app-context/.env /opt/sphere/env
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN cd /tmp \
    && git clone https://github.com/chembience/pychembience.git \
    && cp -r pychembience /opt \
    && rm -rf pychembience

ENTRYPOINT ["/docker-entrypoint.sh"]
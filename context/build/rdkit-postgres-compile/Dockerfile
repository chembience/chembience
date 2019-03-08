ARG build_tag
FROM debian:stretch
LABEL maintainer="markus.sitzmann@gmail.com"


ENV RDBASE="/opt/rdkit"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$RDBASE/lib:/usr/lib/x86_64-linux-gnu"

ENV PG_VERSION=11

ENV RDKIT_BRANCH="Release_2018_09"

WORKDIR /opt

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl wget gosu sudo unzip tar bzip2 \
    git gnupg2 \
    cmake \
    build-essential

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update && apt-get install -y --no-install-recommends  \
    postgresql-server-dev-all \
    postgresql-client \
    postgresql-plpython-${PG_VERSION} \
    postgresql-plpython3-${PG_VERSION} \

    python-numpy \
    python-dev \
    sqlite3 \
    libsqlite3-dev \
    libboost-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-serialization-dev \
    libboost-python-dev \
    libboost-regex-dev \
    libeigen3-dev && \

    git clone -b $RDKIT_BRANCH --single-branch https://github.com/rdkit/rdkit.git && \
    mkdir $RDBASE/build && \
    cd $RDBASE/build && \

    cmake \
      -DRDK_BUILD_INCHI_SUPPORT=ON \
      -DRDK_BUILD_PGSQL=ON \
      -DRDK_BUILD_AVALON_SUPPORT=ON \
      -DPostgreSQL_TYPE_INCLUDE_DIR="/usr/include/postgresql/${PG_VERSION}/server" \
      -DPostgreSQL_ROOT="/usr/lib/postgresql/${PG_VERSION}" .. && \
    make -j `nproc` && \
    make install
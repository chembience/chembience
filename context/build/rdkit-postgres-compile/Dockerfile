ARG build_tag
FROM debian:buster
LABEL maintainer="markus.sitzmann@gmail.com"


ENV RDBASE="/opt/rdkit"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$RDBASE/lib:/usr/lib/x86_64-linux-gnu"

ENV PG_VERSION=11

ENV RDKIT_BRANCH="Release_2019_03"


RUN apt-get update && apt-get -y --no-install-recommends install ca-certificates wget git gnupg2 cmake

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update && apt-get install -y --no-install-recommends  \
    build-essential \
    zlib1g-dev \
    postgresql-server-dev-all \
    postgresql-client-${PG_VERSION} \
    postgresql-plpython-${PG_VERSION} \
    postgresql-plpython3-${PG_VERSION} \
    libboost-dev \
    libboost-system1.67-dev \
    libboost-thread1.67-dev \
    libboost-serialization1.67-dev \
    libboost-python1.67-dev \
    libboost-regex1.67-dev \
    libboost-iostreams1.67-dev \
    libeigen3-dev \
    python3 \
    python3-dev \
    python3-numpy \
    python3-pip \
    python3-pil \
    python3-pandas

WORKDIR /opt

RUN git clone -b $RDKIT_BRANCH --single-branch https://github.com/rdkit/rdkit.git

WORKDIR $RDBASE/build

RUN cmake -Wno-dev \
  -D PYTHON_EXECUTABLE=/usr/bin/python3\
  -D RDK_BUILD_PGSQL=ON \
  -D RDK_PGSQL_STATIC=ON \
  -D RDK_BUILD_INCHI_SUPPORT=ON \
  -D PostgreSQL_TYPE_INCLUDE_DIR="/usr/include/postgresql/${PG_VERSION}/server" \
  -D PostgreSQL_ROOT="/usr/lib/postgresql/${PG_VERSION}" \
  -D RDK_BUILD_PGSQL=ON \
  -D RDK_BUILD_INCHI_SUPPORT=ON \
  -D RDK_BUILD_THREADSAFE_SSS=ON \
  -D RDK_OPTIMIZE_NATIVE=ON \
  ..

RUN make -j $(nproc) && make install


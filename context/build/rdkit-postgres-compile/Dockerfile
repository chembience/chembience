ARG build_tag
FROM debian:stretch
LABEL maintainer="markus.sitzmann@gmail.com"


ENV RDBASE="/opt/rdkit"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$RDBASE/lib:/usr/lib/x86_64-linux-gnu"

ENV PG_VERSION=11

ENV RDKIT_BRANCH="Release_2019_03_b1b"

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    wget \
    git \
    gnupg2 \
    cmake \
    build-essential

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update && apt-get install -y --no-install-recommends  \
    postgresql-server-dev-all \
    postgresql-client-${PG_VERSION} \
    postgresql-plpython-${PG_VERSION} \
    postgresql-plpython3-${PG_VERSION} \
    libboost-all-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-serialization-dev \
    libboost-python-dev \
    libboost-regex-dev \
    libeigen3-dev \
    libeigen3-dev \
    python3 \
    libpython3-dev \
    python3-numpy \
    python3-pip \
    python3-pil \
    python3-pandas

WORKDIR /opt

RUN git clone -b $RDKIT_BRANCH --single-branch https://github.com/rdkit/rdkit.git

WORKDIR $RDBASE/build

RUN cmake -Wno-dev \
  -D RDK_BUILD_PGSQL=ON \
  -D RDK_PGSQL_STATIC=ON \
  -D RDK_BUILD_INCHI_SUPPORT=ON \
  -D PYTHON_EXECUTABLE="/usr/bin/python3" \
  -D PYTHON_INCLUDE_DIR="/usr/include/python3.5" \
  -D PostgreSQL_TYPE_INCLUDE_DIR="/usr/include/postgresql/${PG_VERSION}/server" \
  -D PostgreSQL_ROOT="/usr/lib/postgresql/${PG_VERSION}" \
  -D RDK_BUILD_PGSQL=ON \
  -D RDK_BUILD_INCHI_SUPPORT=ON \
  -D RDK_BUILD_THREADSAFE_SSS=ON \
  -D RDK_OPTIMIZE_NATIVE=ON \
  ..

RUN make -j $(nproc) && make install


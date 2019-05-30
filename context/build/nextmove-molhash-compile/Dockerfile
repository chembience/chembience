ARG build_tag
FROM chembience/rdkit-compile:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com"


ENV MOLHASH_BASE="/opt/molhash"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$RDBASE/lib:/usr/lib/x86_64-linux-gnu"

ENV MOLHASH_BRANCH="master"

WORKDIR /opt

RUN git clone -b $MOLHASH_BRANCH --single-branch https://github.com/nextmovesoftware/molhash.git

WORKDIR $MOLHASH_BASE/build

RUN cmake \
    -D TARGET=RDKIT \
    -D RDKIT_DIR=/opt/rdkit \
    #-DBOOST_ROOT=D:\Tools\boost \
    #-DBOOST_LIBRARYDIR=D:\Tools\boost\boost_1_65_1\lib64-msvc-14.1 \
    ..

RUN make -j $(nproc)


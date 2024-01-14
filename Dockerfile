FROM debian:12-slim

LABEL github="https://github.com/fcqpl/docker-icecast-kh"

ARG ICECAST_KH_VERSION=2.4.0-kh20

# install icecast2 and enable its autostart
RUN apt update && apt upgrade -y && \
    apt-get install build-essential libxslt-dev libvorbis-dev libxml2 libssl-dev wget -y && \
    wget https://github.com/karlheyes/icecast-kh/archive/refs/tags/icecast-${ICECAST_KH_VERSION}.tar.gz && \
    tar -xvf icecast-${ICECAST_KH_VERSION}.tar.gz && rm icecast-${ICECAST_KH_VERSION}.tar.gz && \
    cd icecast-kh-icecast-${ICECAST_KH_VERSION} && \
    ./configure --with-openssl && make && make install && \
    mkdir -p /etc/icecast2 && cp /usr/local/etc/icecast.xml /etc/icecast2 && \
    apt purge build-essential -y && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD /usr/local/bin/icecast -c /etc/icecast2/icecast.xml

FROM debian:12-slim as build

LABEL github="https://github.com/disconn3ct/docker-icecast-kh"

ARG ICECAST_KH_VERSION=2.4.0-kh22

# install icecast2 and enable its autostart
RUN apt update && apt upgrade -y && \
    apt-get install build-essential libxslt-dev libvorbis-dev libxml2 libssl-dev curl -y && \
    curl -fsSL https://github.com/karlheyes/icecast-kh/archive/refs/tags/icecast-${ICECAST_KH_VERSION}.tar.gz | tar xvzf - && \
    cd icecast-kh-icecast-${ICECAST_KH_VERSION} && \
    ./configure --with-openssl --prefix=/opt/icecast && make -j && make install

FROM debian:12-slim
RUN apt update && apt upgrade -y && \
    apt-get install libxslt1.1 libvorbis0a libvorbisenc2 libxml2 libssl3 media-types -y && \
    apt autoremove -y && apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/ /opt/.

RUN mkdir -p /etc/icecast2 && cp /opt/icecast/etc/icecast.xml /etc/icecast2

COPY json-stats/* /opt/icecast/share/icecast/web/.

CMD /opt/icecast/bin/icecast -c /etc/icecast2/icecast.xml

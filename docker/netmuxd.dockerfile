FROM usbmuxd

WORKDIR /work
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    autoconf automake \
    curl \
    wget lsb-release wget software-properties-common \
    clang
RUN apt-get update &&\
    apt-get install -y \ 
    libavahi-glib-dev libavahi-client-dev \
    libtool 

RUN for i in /etc/ssl/certs/*.pem; do HASH=$(openssl x509 -hash -noout -in $i); ln -s $(basename $i) /etc/ssl/certs/$HASH.0 || true; done

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV CARGO_NET_GIT_FETCH_WITH_CLI=true

RUN . "$HOME/.cargo/env" && cargo install cargo-chef

RUN git clone https://github.com/zeyugao/zeroconf-rs.git \
    && git clone https://github.com/jkcoxson/mdns.git

RUN cd zeroconf-rs && git checkout 860b030064308d4318e2c6936886674d955c6472 && cd .. \
    && cd mdns && git checkout 961ab21b5e01143dc3a7f0ba5f654285634e5569 && cd ..
RUN git clone https://github.com/jkcoxson/netmuxd

RUN . "$HOME/.cargo/env" \
    && cd netmuxd \
    && cargo chef prepare --recipe-path recipe.json \
    && cargo chef cook --release --recipe-path recipe.json \
    && cargo chef cook --release --recipe-path recipe.json --features "zeroconf"

RUN mkdir -p /output/ \
    && cd netmuxd \
    && . "$HOME/.cargo/env" \
    && cargo build --release --features "zeroconf" \
    && cp target/release/netmuxd /output/netmuxd-zeroconf \
    && cargo build --release \
    && cp target/release/netmuxd /output/netmuxd-mdns
##COMPILING IS BROKE, GET PREBUILT BINARY (YEAH ALL OF THIS IS USELESS) ARM PINE64
RUN wget https://github.com/darderik/altserverd/raw/a5c75dfe858ff4fa02226e6d12b58b00e013139d/bin/netmuxd-zeroconf -O /output/netmuxd-zeroconf


ENTRYPOINT [ "/bin/bash" ]

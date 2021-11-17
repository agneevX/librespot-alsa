FROM alpine:edge

ARG LIBRESPOT_VER="v0.3.1"

RUN apk -U add curl cargo portaudio-dev protobuf-dev \
 && cargo --version \
 && rustc --version \
 && cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/refs/tags/$LIBRESPOT_VER.zip \
 && unzip *.zip \
 && cd librespot* \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features --features alsa-backend \
 && mv ./target/release/librespot /usr/local/bin \
 && apk --purge del curl cargo portaudio-dev protobuf-dev \
 && apk add alsa-lib libgcc \
 && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/*.zip /root/librespot* /root/.cargo

ENTRYPOINT ["/usr/local/bin/librespot", "--backend=alsa", "--disable-audio-cache"]
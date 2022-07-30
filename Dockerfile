FROM alpine:latest as builder

ARG LIBRESPOT_VERSION="v0.3.1"

RUN apk -U add \
        curl \
        cargo \
        portaudio-dev \
        protobuf-dev

RUN cd /root && \
    curl -LO https://github.com/librespot-org/librespot/archive/refs/tags/$LIBRESPOT_VERSION.zip \
    && unzip *.zip

RUN cd /root/librespot* \
    && cargo build \
        --jobs $(grep -c ^processor /proc/cpuinfo) \
        --release \
        --no-default-features \
        --features alsa-backend

FROM alpine:latest as final

RUN apk add -U alsa-lib

COPY --from=builder /root/librespot*/target/release/librespot /app/librespot

ENTRYPOINT ["/app/librespot", "--backend=alsa", "--disable-audio-cache"]
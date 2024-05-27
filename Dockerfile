FROM alpine:3.16 as builder

ARG LIBRESPOT_VERSION="v0.4.2"

RUN apk -U add \
        curl \
        cargo \
        portaudio-dev \
        protobuf-dev

WORKDIR /root

RUN curl -LO https://github.com/librespot-org/librespot/archive/refs/tags/$LIBRESPOT_VERSION.zip \
    && unzip *.zip

RUN cd librespot* \
    && cargo build \
        --release \
        --jobs $(grep -c ^processor /proc/cpuinfo) \
        --no-default-features \
        --features alsa-backend

FROM alpine:3.16 as final

RUN apk add -U alsa-lib

COPY --from=builder /root/librespot*/target/release/librespot /app/librespot

ENTRYPOINT ["/app/librespot", "--backend=alsa", "--disable-audio-cache"]

FROM alpine:latest as builder

ARG LIBRESPOT_VERSION="v0.4.2"

RUN apk -U add \
        git \
        curl \
        cargo \
        portaudio-dev \
        protobuf-dev

WORKDIR /root

RUN git clone https://github.com/librespot-org/librespot \
    && cd librespot \
    && git checkout dev \
    && cargo build \
        --no-default-features \
        --features alsa-backend

FROM alpine:latest as final

RUN apk add -U alsa-lib

COPY --from=builder /root/librespot/target/release/librespot /app/librespot

ENTRYPOINT ["/app/librespot", "--backend=alsa", "--disable-audio-cache"]
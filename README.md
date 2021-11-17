# Librespot-alsa

### Note: `arm64` only at the moment

Librespot image compiled with alsa backend. This is the latest version of librespotify (v.0.3.1) as of Nov 2021.

## Docker-compose

```yml
version: "2.1"

services:
  librespot:
    container_name: librespot
    image: agneev/librespot-alsa
    restart: unless-stopped
    network_mode: host # Comment to use Docker networking
    command:
      - --name=Spotify Speaker
      - --bitrate=320
      - --autoplay
      - --initial-volume=75
      - --enable-volume-normalisation
     # - --disable-discovery # Uncomment to disable mDNS discovery
     # - --username=$SPOTIFY_USERNAME # Uncomment to 
     # - --password=$SPOTIFY_PASSWORD # use Spotify sign-in
    environment:
      SPOTIFY_NAME: "Loud Speakers"
    devices:
      - /dev/snd:/dev/snd
```
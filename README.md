# Librespot-alsa

Librespot Docker image compiled with the alsa backend.

Librespot lets you play content from Spotify to a speaker connected to your server. Note that this requires a Spotify Premium account.

Refer to the librespot project [here](https://github.com/librespot-org/librespot).

## Image

Pull Docker image

```text
docker pull agneev/librespot-alsa
```

### Deploy

```text
git clone https://github.com/agneevX/librespot-alsa
cd librespot-alsa

docker compose up -d
```

For more examples, refer to the documentation linked above.

```yml
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
    devices:
      - /dev/snd:/dev/snd
```

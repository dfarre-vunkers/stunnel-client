
## stunnel-client docker
### Build arm image
docker buildx build  --no-cache --platform arm64 --output=type=docker -t stunnel-client .

### Build arm image
docker save stunnel-client > /path/stunnel-client.tar

### Instalation on Mikrotik
- Create directory with crt & key
- Create mount from the above directory to /data
- Create env with:
    - STUNNEL_SERVICE
    - STUNNEL_ACCEPT
    - STUNNEL_CONNECT
    - STUNNEL_CRT
    - STUNNEL_KEY
- Create container with stunnel-client.tzr envlist and mounts



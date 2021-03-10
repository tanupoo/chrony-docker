chrony
======

## Dockerfile

```
FROM alpine:3.12
RUN apk add chrony=3.5.1-r0
CMD ["/usr/sbin/chronyd", "-r", "-s", "-d"]
```

## build

```
docker build --tag chrony:3.5.1-r0 .
```

## configure

- edit etc/chrony.conf
- configure the IP address of the upper NTP server.
- you can skip setting above IP address if you don't need the upper NTP server.
- you have to configure at least one allow directive otherwise the chronyd doesn't respond any queries..

```
server 192.168.1.205 offline
allow 10.0.0.1/24
local stratum 5
cmdport 123
driftfile /chrony/chrony.drift
dumpdir /chrony/dump
rtconutc
```

## run

```
docker run \
    --name chronyd \
    --privileged=true \
    --volume `pwd`/etc:/chrony \
    --publish 123:123/udp \
    chrony:3.5.1-r0 \
    /usr/sbin/chronyd -r -s -f /chrony/chrony.conf -d
```

## check

```
docker exec chronyd chronyc tracking
docker exec chronyd chronyc sources
```


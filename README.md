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

```
server 192.168.1.205 offline
local stratum 5
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
    --publish 123:123 \
    chrony:3.5.1-r0 \
    /usr/sbin/chronyd -r -s -f /chrony/chrony.conf -d
```

## check

```
docker exec chronyd chronyc tracking
docker exec chronyd chronyc sources
```


FROM alpine:3.12

RUN apk add chrony=3.5.1-r0

CMD ["/usr/sbin/chronyd", "-r", "-s", "-d"]

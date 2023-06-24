# syntax=docker/dockerfile:1
FROM tailscale/tailscale:v1.42.0

RUN apk add --no-cache socat tini

COPY src/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV SOCAT_BIND_TYPE=
ENV SOCAT_BIND_IFACE=
ENV SOCAT_BIND_OPTS=
ENV SOCAT_CONNECT_TYPE=
ENV SOCAT_CONNECT_IFACE=
ENV SOCAT_CONNECT_OPTS=

ENV SOCAT_PORTFORWARD=

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

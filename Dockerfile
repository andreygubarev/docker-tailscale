# syntax=docker/dockerfile:1
FROM tailscale/tailscale:v1.42.0

RUN apk add --no-cache socat tini

COPY src/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV TS_PORTFORWARD=

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

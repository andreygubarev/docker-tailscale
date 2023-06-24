#!/bin/sh
set -ex

if [ -n "${SOCAT_PORTFORWARD}" ]; then
    SOCAT_BIND_TYPE="${SOCAT_BIND_TYPE:-tcp-listen}"
    SOCAT_BIND_IFACE="${SOCAT_BIND_IFACE:-${SOCAT_PORTFORWARD%%:*}}"
    SOCAT_BIND_OPTS="${SOCAT_BIND_OPTS:-fork,reuseaddr}"
    SOCAT_CONNECT_TYPE="${SOCAT_CONNECT_TYPE:-tcp}"
    SOCAT_CONNECT_IFACE="${SOCAT_CONNECT_IFACE:-${SOCAT_PORTFORWARD#*:}}"
    SOCAT_CONNECT_OPTS="${SOCAT_CONNECT_OPTS:-}"
fi

if [ -n "${SOCAT_BIND_TYPE}" ] && [ -n "${SOCAT_BIND_IFACE}" ]; then
    if [ -n "${SOCAT_BIND_OPTS}" ]; then
        SOCAT_BIND_OPTS=",${SOCAT_BIND_OPTS}"
    fi
    SOCAT_BIND="${SOCAT_BIND_TYPE}:${SOCAT_BIND_IFACE}${SOCAT_BIND_OPTS}"
fi

if [ -n "${SOCAT_CONNECT_TYPE}" ] && [ -n "${SOCAT_CONNECT_IFACE}" ]; then
    if [ -n "${SOCAT_CONNECT_OPTS}" ]; then
        SOCAT_CONNECT_OPTS=",${SOCAT_CONNECT_OPTS}"
    fi
    SOCAT_CONNECT="${SOCAT_CONNECT_TYPE}:${SOCAT_CONNECT_IFACE}${SOCAT_CONNECT_OPTS}"
fi

if [ -n "${SOCAT_BIND}" ] && [ -n "${SOCAT_CONNECT}" ]; then
    socat "${SOCAT_BIND}" "${SOCAT_CONNECT}" &
fi

containerboot "$@"

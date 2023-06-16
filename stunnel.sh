#!/bin/sh -e

export STUNNEL_CONF="/etc/stunnel/stunnel.conf"
export STUNNEL_DEBUG="${STUNNEL_DEBUG:-7}"
export STUNNEL_UID="${STUNNEL_UID:-stunnel}"
export STUNNEL_GID="${STUNNEL_GID:-stunnel}"
export STUNNEL_KEY="${STUNNEL_KEY:-/etc/stunnel/stunel.key}"
export STUNNEL_CRT="${STUNNEL_CRT:-/etc/stunnel/stunnel.pem}"
export STUNNEL_DELAY="${STUNNEL_DELAY:-no}"
export STUNNEL_CLIENT="${STUNNEL_CLIENT:-yes}"
export STUNNEL_CAFILE="${STUNNEL_CAFILE:-/etc/ssl/certs/ca-certificates.crt}"
export STUNNEL_VERIFY_CHAIN="${STUNNEL_VERIFY_CHAIN:-no}"
export STUNNEL_VERIFY="${STUNNEL_VERIFY:-0}"
export STUNNEL_DELAY="${STUNNEL_DELAY:-no}"

if [[ -z "${STUNNEL_SERVICE}" ]] || [[ -z "${STUNNEL_ACCEPT}" ]] || [[ -z "${STUNNEL_CONNECT}" ]]; then
    echo >&2 "one or more STUNNEL_SERVICE* values missing: "
    echo >&2 "  STUNNEL_SERVICE=${STUNNEL_SERVICE}"
    echo >&2 "  STUNNEL_ACCEPT=${STUNNEL_ACCEPT}"
    echo >&2 "  STUNNEL_CONNECT=${STUNNEL_CONNECT}"
    exit 1
fi


function trim() {
    awk '{$1=$1};1'
}

if [[ ! -s ${STUNNEL_CONF} ]]; then
    cat /srv/stunnel/stunnel.conf.template | envsubst | trim > ${STUNNEL_CONF}
fi

exec "$@"

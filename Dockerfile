FROM alpine:latest

RUN set -x \
 && addgroup -S stunnel \
 && adduser -S -G stunnel stunnel \
 && apk add --update --no-cache \
        ca-certificates \
        libintl \
        openssl \
        stunnel \
 && grep main /etc/apk/repositories > /etc/apk/main.repo \
 && apk add --update --no-cache --repositories-file=/etc/apk/main.repo \
        gettext \
 && cp -v /usr/bin/envsubst /usr/local/bin/ \
 && apk del --purge \
        gettext \
 && apk --no-network info openssl \
 && apk --no-network info stunnel
COPY *.template openssl.cnf /srv/stunnel/
COPY stunnel.sh /srv/

RUN set -x \
 && chmod +x /srv/stunnel.sh \
 && mkdir -p /var/run/stunnel /var/log/stunnel \
 && chown -vR stunnel:stunnel /var/run/stunnel /var/log/stunnel \
 && mv -v /etc/stunnel/stunnel.conf /etc/stunnel/stunnel.conf.original

ENTRYPOINT ["/srv/stunnel.sh"]
CMD ["stunnel"]

LABEL org.label-schema.name="stunnel-client" \
      org.label-schema.description="Stunnel client on Alpine" \
      org.label-schema.url="https://github.com/dfarre-vunkers/stunnel-client/" \
      org.label-schema.usage="https://github.com/dfarre-vunkers/stunnel-client/blob/master/README.md" \
      org.label-schema.vcs-url="https://github.com/dfarre-vunkers/stunnel-client/" \
      org.label-schema.vendor="David Farré - mailto:dfarre@vunkers.com, https://github.com/dfarre-vunkers" \
      org.label-schema.schema-version="1.0"

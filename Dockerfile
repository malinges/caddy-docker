FROM alpine:3.7
LABEL mantainer="Eloy Lopez <elswork@gmail.com>"

LABEL caddy_version="0.11.0" architecture="arm7"

ARG plugins=http.cors,http.nobots,tls.dns.gandiv5
ARG architecture=arm7

RUN apk add --no-cache openssh-client git tar curl

# install caddy
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/${architecture}?plugins=${plugins}&license=personal" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

EXPOSE 80 443 2015
VOLUME /root/.caddy
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile
COPY index.html /srv/index.html

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--agree", "--conf", "/etc/Caddyfile", "--log", "stdout"]

# Caddy for arm

A [Docker](http://docker.com) image for [Caddy](http://caddyserver.com) that will let you to serve http or https with Let's Encrypt certificate autogenerated. This image includes the [git](http://caddyserver.com/docs/git) plugin. Plugins can be configured via the `plugins` build arg. Forked from [abiosoft/caddy-docker](https://github.com/abiosoft/caddy-docker/) ~~replacing the official [Alpine Linux](https://alpinelinux.org) base image with [hypriot/rpi-alpine-scratch](https://github.com/hypriot/rpi-alpine-scratch) from the amazing people of [Hypriot Pirate Crew](http://blog.hypriot.com/) in order to build a suitable image for arm devices such as rpi, odroid. I replaced this image in latest version with almost docker official image [arm32v6/alpine](https://hub.docker.com/r/arm32v6/alpine/) from [Docker Official Images](https://github.com/docker-library/official-images#architectures-other-than-amd64)~~

## Details
- [Source Repository](https://github.com/DeftWork/caddy-docker)
- [Deft.Work my personal blog](http://deft.work)

## Enhancements
- Upgraded Caddy version to 0.11.0
- [Return to original base image Alpine 3.7](https://hub.docker.com/r/_/alpine/)

## Getting Started

This is a simple usage for testing proposes.

```sh
$ docker run -d -p 2015:2015 elswork/arm-caddy:latest
```

Point your browser to `http://127.0.0.1:2015`.

## My Real Usage Example

In order everyone could take full advantages of the usage of this docker container, I'll describe my own real usage setup.
```sh
$ docker run -d \
    --name myarm-caddy \
    -p 80:80 -p 443:443 \
    -v /var/www/html:/srv \
    -v $HOME/Caddyfile/https:/etc/Caddyfile \
    -v $HOME/.caddy:/root/.caddy \
    elswork/arm-caddy:latest
```
`--name myarm-caddy` This is absolutely optional, it helps to me to easily identify and operate the container after the first execution.
```sh
$ docker start myarm-caddy
$ docker stop myarm-caddy
$ docker rm myarm-caddy
...
```
`-p 80:80 -p 443:443` Caddy will serve https by default.

`-v /var/www/html:/srv` /var/www/html is the local folder where I have the files to serve. I mount in the container folder that Caddy use to serve files.

`-v $HOME/Caddyfile/https:/etc/Caddyfile` $HOME/Caddyfile/https is my Caddy configuration file. 
```
mydomain.com, www.mydomain.com {
browse
gzip
log stdout
errors stdout
tls user@host.com
}
```

`-v $HOME/.caddy:/root/.caddy` I mount the folder where I will store the Let's Encrypt certificates that will be generated automatically the first time the container run, in order to prevent regenerating them each time.

## Let's Encrypt Auto SSL
**Note** that this does not work on local environments.

You must use a valid domain properly configured to point your docker server and add email to your Caddyfile to avoid prompt at runtime.

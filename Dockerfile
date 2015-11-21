FROM alpine:3.2
MAINTAINER Nagy Károly Gábriel <karasz@jpi.io>

RUN apk add --update openssh-client git tar asciidoc

RUN mkdir /caddysrc \
&& curl -sL -o /caddysrc/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/build?os=linux&arch=amd64&features=git,hugo,ipfilter,search" \
&& tar -xf /caddysrc/caddy_linux_amd64.tar.gz -C /caddysrc \
&& mv /caddysrc/caddy /usr/bin/caddy \
&& chmod 755 /usr/bin/caddy \
&& rm -rf /caddysrc
ADD docker/Caddyfile /etc/Caddyfile
ADD docker/id_rsa /etc/id_rsa
RUN mkdir -p /srv/git
RUN mkdir -p /srv/html

EXPOSE 2015

WORKDIR /srv
CMD ["/bin/sh"]
#ENTRYPOINT ["/usr/bin/caddy"]
#CMD ["--conf", "/etc/Caddyfile"]

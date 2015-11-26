FROM alpine:3.2
MAINTAINER Nagy Károly Gábriel <karasz@jpi.io>

RUN apk add --update openssh-client git tar asciidoc

## Install Caddy Server
#
RUN mkdir /caddysrc \
&& curl -sL -o /caddysrc/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/build?os=linux&arch=amd64&features=git" \
&& tar -xf /caddysrc/caddy_linux_amd64.tar.gz -C /caddysrc \
&& mv /caddysrc/caddy /usr/bin/caddy \
&& chmod 755 /usr/bin/caddy \
&& rm -rf /caddysrc

## Install Wellington
#
RUN mkdir /wtsrc \
&& curl -sL -o /wtsrc/wt__linux_amd64.tar.gz "https://github.com/wellington/wellington/releases/download/v1.0.1/wt_v1.0.1_linux_amd64.tar.gz" \
&& tar -xf /wtsrc/wt__linux_amd64.tar.gz -C /wtsrc \
&& mv /wtsrc/*/wt /usr/bin/wt \
&& chmod 755 /usr/bin/wt \
&& rm -rf /wtsrc

## Install nodejs and then jade
#
RUN apk add --update nodejs
RUN npm install jade -g
RUN rm -rf /var/cache/apk/*

## Add files
#
ADD docker/Caddyfile /etc/Caddyfile
ADD docker/id_rsa /etc/id_rsa
ADD docker/builder.sh /usr/bin/builder
RUN chmod +x /usr/bin/builder

RUN mkdir -p /srv/git
RUN mkdir -p /srv/html

EXPOSE 2015

WORKDIR /srv
CMD ["/bin/sh"]
#ENTRYPOINT ["/usr/bin/caddy"]
#CMD ["--conf", "/etc/Caddyfile"]

FROM alpine:3.2

RUN apk --update add make wget go git gcc musl-dev openssl-dev curl bash ca-certificates

RUN export GOPATH=/tmp/go \
	&& go get -u -v github.com/hashicorp/consul

RUN export GOPATH=/tmp/go \
	&& cd /tmp/go/src/github.com/hashicorp/consul \
  	&& git checkout v0.5.2 \
  	&& make \
  	&& mv bin/consul /bin/

RUN wget https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip  -O /tmp/ui.zip \
	&& unzip /tmp/ui.zip -d /tmp/ \
	&& mv /tmp/dist /ui

RUN wget https://get.docker.io/builds/Linux/x86_64/docker-1.7.0 -O /bin/docker

RUN cat /etc/ssl/certs/*.crt > /etc/ssl/certs/ca-certificates.crt && \
    sed -i -r '/^#.+/d' /etc/ssl/certs/ca-certificates.crt

ADD ./bin/start /bin/start
ADD ./bin/check-http /bin/check-http
ADD ./bin/check-cmd /bin/check-cmd

RUN chmod +x -R /bin/

RUN apk del make go git gcc musl-dev openssl-dev
RUN rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
VOLUME ["/data", "/config"]

ENV SHELL /bin/bash

ENTRYPOINT ["/bin/start"]
CMD []


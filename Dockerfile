FROM alpine:3.2

ADD https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip

ADD https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip /tmp/webui.zip
RUN mkdir /ui && cd /ui && unzip /tmp/webui.zip && mv dist/* . && rm -rf dist

ADD https://get.docker.io/builds/Linux/x86_64/docker-1.7.0 /bin/docker

RUN opkg-install curl bash ca-certificates

RUN cat /etc/ssl/certs/*.crt > /etc/ssl/certs/ca-certificates.crt && \
    sed -i -r '/^#.+/d' /etc/ssl/certs/ca-certificates.crt

ADD ./bin/start /bin/start
ADD ./bin/check-http /bin/check-http
ADD ./bin/check-cmd /bin/check-cmd

RUN chmod +x -R /bin/

RUN rm -rf /tmp/*

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
VOLUME ["/data", "/config"]

ENV SHELL /bin/bash

ENTRYPOINT ["/bin/start"]
CMD []


## Consul on Docker

### Base image

The base image used is alpine (version 3.2) (https://www.alpinelinux.org/). Alpine Linux is a security-oriented, lightweight Linux distribution based on musl libc and busybox.
 
### Concept

This image differs from the official progrium/consul (https://github.com/progrium/docker-consul) by the config folder which is a volume.

### Usage

Usage and options can be found on https://github.com/progrium/docker-consul, don't forget to share your config folder, basically:

````docker run -v /var/my/config:/config:ro -p 8500:8500 -p 53:53 ebuildy/consul -server -bootstrap -ui-dir /ui````

### Configuration

Configuration files option can be found here: https://www.consul.io/docs/agent/options.html.


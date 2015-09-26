# Docker confd

[Confd](https://github.com/kelseyhightower/confd) is a lightweight configuration management tool, this is containerised version based on top of [Alpine Linux](http://www.alpinelinux.org) with an incredibly tiny image size of 25 MB uncompressed.

[![Circle CI](https://circleci.com/gh/ianbytchek/docker-confd.svg?style=svg)](https://circleci.com/gh/ianbytchek/docker-confd)

## Running

All super simple, just run the container with `/etc/confd` folders mounted as volumes, see [build/ci/script/test.sh](build/ci/script/test.sh) for a detailed example.

```sh
docker run \
    --detach \
    --name 'confd' \
    --volume '/foo/bar/confd:/etc/confd' \
    ianbytchek/confd
```

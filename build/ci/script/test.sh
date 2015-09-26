#!/usr/bin/env bash

# Setup error trapping.

set -e
trap 'echo "Error occured on line $LINENO." && exit 1' ERR

# Bring up etcd service container and wait a little until etcd gets initialised.

docker run \
    --detach \
    --name 'etcd' \
    --net 'host' \
    quay.io/coreos/etcd

sleep 1;

# Start confd container.

path=$(pwd)

docker run \
    --detach \
    --name 'confd' \
    --net 'host' \
    --volume "${path}/test:/etc/confd" \
    ianbytchek/confd

sleep 1;

echo -n "Verify template doesn't get rendered without no keys."
if [ ! -f './test/output/foo.conf' ]; then
echo ' OK!'; else echo ' Fail!'; exit 1; fi;

curl --location --request 'PUT' --data 'value=foo' http://localhost:4001/v2/keys/services/x
sleep 1;

echo -n 'Verify template has only foo value.'
if cat './test/output/foo.conf' | grep -Pq '^foo$'; then
echo ' OK!'; else echo ' Fail!'; exit 1; fi;

curl --location --request 'PUT' --data 'value=bar' http://localhost:4001/v2/keys/services/y
curl --location --request 'DELETE' http://localhost:4001/v2/keys/services/x
sleep 1;

echo -n 'Verify template has only bar value.'
if cat './test/output/foo.conf' | grep -Pq '^bar$'; then
echo ' OK!'; else echo ' Fail!'; exit 1; fi;

curl --location --request 'PUT' --data 'value=baz' http://localhost:4001/v2/keys/services/z
sleep 1;

echo -n 'Verify template has only bar and baz value.'
if cat './test/output/foo.conf' | grep -Pq '^bar,baz|baz,bar$'; then
echo ' OK!'; else echo ' Fail!'; exit 1; fi;
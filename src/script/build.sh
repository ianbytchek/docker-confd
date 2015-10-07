#!/usr/bin/env sh

set -euo pipefail

echo -n 'Moving confd binary into $PATH… '
mv '/docker/confd' '/usr/bin'
echo ' OK!'

echo -n 'Moving docker binary into $PATH… '
mv '/docker/docker' '/usr/bin'
echo ' OK!'

echo -n 'Cleaning up container…'
rm -rf /docker
echo ' OK!'

echo 'Bye-bye!'
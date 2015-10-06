#!/usr/bin/env bash

set -euo pipefail

# Download the latest confd executable and build the docker image.

echo -n 'Finding condf release url… '
releases=$(curl --header "Authorization: token ${GITHUB_TOKEN}" --silent https://api.github.com/repos/kelseyhightower/confd/releases)
url=$(echo "${releases}" | jq --raw-output 'map(select(.prerelease == false and .draft == false))[0].assets | map(select(.name | endswith("linux-amd64")))[0].browser_download_url')
echo " OK! ${url}"

curl --output './src/confd' --location "$url"
chmod +x './src/confd'

echo -n 'Finding docker release url… '
releases=$(curl --header "Authorization: token ${GITHUB_TOKEN}" --silent 'https://api.github.com/repos/docker/docker/releases')
release=$(echo "${releases}" | jq --raw-output 'map(select(.prerelease == false and .draft == false) | .tag_name)[0][1:]')
url="https://get.docker.com/builds/Linux/x86_64/docker-${release}.tgz"
echo " OK! ${url}"

curl --output 'docker.tgz' --location "$url"
mkdir 'docker'
tar -zx --directory 'docker' --strip 3 --file 'docker.tgz'
cp './docker/docker' './src'

docker build --tag "ianbytchek/confd" "./src"
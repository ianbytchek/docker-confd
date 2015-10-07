#!/usr/bin/env bash

set -euo pipefail

# We will need the latest jq, circle has grey-haired versions installed as always.

sudo bash -c 'echo deb "http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" > /etc/apt/sources.list'
sudo apt-get update
sudo apt-get install jq
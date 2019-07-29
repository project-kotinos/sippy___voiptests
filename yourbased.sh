#!/usr/bin/env bash
set -e

echo "+++ hosts orig +++"
cat /etc/hosts
echo "--- hosts orig ---"
sh -c 'echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6'
sh -c 'echo >> /etc/hosts; grep "^127.0.0.1" /etc/hosts | sed "s|^127.0.0.1|::1|g" >> /etc/hosts'
echo "+++ hosts patched +++"
cat /etc/hosts
echo "--- hosts patched ---"
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install gpp
sh -x ./install_depends/opensips.sh
sh -x ./test_run.sh

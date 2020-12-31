#!/bin/sh
set -e

for e in $(ls /proc/sys/net/ipv4/conf/e* -d); do
export IP_ETH=$(ip -4 address show up dev $(basename $e) | grep -o -E '(([0-9]{1,3}[\.]){3}[0-9]{1,3})' | sed '1!d');
done;

php -S $IP_ETH:80 -t /var/www/html

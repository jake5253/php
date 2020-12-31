#!/bin/bash
EXT=$@
for element in $EXT
do
  echo "extention=$element" | tee -a /usr/local/lib/php.ini
done
echo "zend_extension=opcache.so" | tee -a /usr/local/lib/php.ini


for IMG in $(docker images -q)
do
    docker rmi -f $IMG
done

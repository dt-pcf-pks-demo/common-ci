#!/bin/bash
cd ~/workspace/dt-pcf-pks-demo/order-service
git checkout 2
sed -i -r 's/(.*)(incrementthistoforcenewrelease: )([0-9]+)(.*)/echo "\1\2$((\3+1))\4"/ge' manifests/manifest.yml
git add manifests/manifest.yml
git commit -m "forcing build"
git push origin 2

#!/bin/bash
#set -ex

INPUT='tv-production-release.apk=>https://app.bitrise.io/artifact/29147490/p/52e6ffff6ea33100359e6660cb674fd3|mobile-production-universal-release.apk=>https://app.bitrise.io/artifact/29147494/p/f3523ef744ce1d3d8607cbc2378cd34a|mobile-production-universal-release20200115193033.apk=>https://app.bitrise.io/artifact/29147499/p/8924996f1a0d6c1f96798cfb866f359e|mobile-production-debug-androidTest.apk=>https://app.bitrise.io/artifact/29147482/p/b37aa7957a82789e054b1fef8c8d67c5|mobile-production-debug-androidTest20200115190912.apk=>https://app.bitrise.io/artifact/29147483/p/4a3b998e35984a0bbf00e0ff34ac0052|mobile-production-debug.apk=>https://app.bitrise.io/artifact/29147484/p/9f6c6552835984e103a671e9104497c3|mobile-production-release.apk=>https://app.bitrise.io/artifact/29147487/p/030144fc3a80d597bef350adb1723a7c'
COUNT=$(echo $INPUT| grep -o "=>" | wc -l)

for ((INDEX = 1 ; INDEX <= $COUNT ; INDEX++)); do
    KEY=$(echo $(echo $INPUT| cut -d'|' -f $INDEX)| cut -d'=' -f 1)
    VALUE=$(echo $(echo $INPUT| cut -d'|' -f $INDEX)| cut -d'=' -f 2)
    VALUE=${VALUE#">"}
    echo "$INDEX -> $KEY : $VALUE"
done

#!/bin/bash

COUNT=$(echo $INPUT| grep -o "=>" | wc -l)

for ((INDEX = 1 ; INDEX <= $COUNT ; INDEX++)); do
    KEY=$(echo $(echo $INPUT| cut -d'|' -f $INDEX)| cut -d'=' -f 1)
    VALUE=$(echo $(echo $INPUT| cut -d'|' -f $INDEX)| cut -d'=' -f 2)
    VALUE=${VALUE#">"}    
    if [ "$KEY" == "$TARGET" ]; then        
        BITRISE_CUSTOM_ARTIFACT_URL=$VALUE
    fi
done

#!/bin/bash

echo "Input: $INPUT"
echo "Target: $TARGET"

COUNT=$(echo $INPUT| grep -o "=>" | wc -l)

echo "Artifacts count: $COUNT "

for ((INDEX = 1 ; INDEX <= $COUNT ; INDEX++)); do
    KEY=$(echo $(echo $INPUT| cut -d'|' -f $INDEX)| cut -d'=' -f 1)
    VALUE=$(echo $(echo $INPUT| cut -d'|' -f $INDEX)| cut -d'=' -f 2)
    VALUE=${VALUE#">"}    
    echo "Parse Artifact: $KEY -> $VALUE"
    if [ "$KEY" == "$TARGET" ]; then    
        export BITRISE_CUSTOM_ARTIFACT_URL=$VALUE
        echo "Target Finded: $VALUE"
    fi
done

echo "Finded Artifact: ( $BITRISE_CUSTOM_ARTIFACT_URL )"

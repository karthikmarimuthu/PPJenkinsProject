#!/bin/bash
BUILD_NU=$(echo $BUILD_NUMBER)
REL=$(for i in $(grep '<version>' pom.xml); do ver=${i%<*}; ver=${ver#*>}; echo "$ver"; done | head -1)
TVER=$REL.$BUILD_NU 
echo "VERSION=$TVER" > /tmp/auto/release-$app.txt
chmod -R 777 /tmp/auto/release-$app.txt

#!/bin/bash
BUILD_NU=$(echo $BUILD_NUMBER)
REL=$(for i in $(grep '<version>' pom.xml); do ver=${i%<*}; ver=${ver#*>}; echo "$ver"; done | head -1)
TVER=$REL.$BUILD_NU
echo "VERSION=$TVER" > /tmp/auto/release-$app.txt
chmod -R 777 /tmp/auto/release-$app.txt
if echo "$VERSION" | grep -q "SNAPSHOT"; then
echo "repo=snapshots" > /tmp/auto/release-$app.txt
source /tmp/auto/release-$app.txt
wdir=/data/nexus/storage/$repo/au/
/bin/bash /usr/local/sbin/reporemove.sh
/bin/bash /usr/local/sbin/repoadd.sh
else
echo "repo=releases" > /tmp/auto/release-$app.txt
source /tmp/auto/release-$app.txt
wdir=/data/nexus/storage/$repo/au/
/bin/bash /usr/local/sbin/reporemove.sh
/bin/bash /usr/local/sbin/repoadd.sh
fi

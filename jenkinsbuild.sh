#!/bin/bash
BUILD_NU=$(echo $BUILD_NUMBER)
REL=$(for i in $(grep '<version>' pom.xml); do ver=${i%<*}; ver=${ver#*>}; echo "$ver"; done | head -1)
VERSION=$REL.$BUILD_NU 
echo "$VERSION" > /tmp/auto/release-$app.txt
chmod -R 777 /tmp/auto/release-$app.txt
source /tmp/auto/release-$app.txt
if echo "$VERSION" | grep -q "SNAPSHOT"; then
repo=echo "snapshots"
wdir=/data/nexus/storage/$repo/au/
/bin/bash /usr/local/sbin/reporemove.sh
/bin/bash /usr/local/sbin/repoadd.sh
else
repo=echo "releases"
wdir=/data/nexus/storage/$repo/au/
/bin/bash /usr/local/sbin/reporemove.sh
/bin/bash /usr/local/sbin/repoadd.sh
fi

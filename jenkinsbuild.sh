#!/bin/bash
#pass parameters from other job to the build job
BUILD_NU=$(echo $BUILD_NUMBER)
REL=$(for i in $(grep '<version>' pom.xml); do ver=${i%<*}; ver=${ver#*>}; echo "$ver"; done | head -1)
TVER=$REL.$BUILD_NU
echo "VERSION=$TVER" >> /tmp/auto/release-$app.txt
chmod -R 777 /tmp/auto/release-$app.txt
source /tmp/auto/release-$app.txt
echo $VERSION
if echo "$VERSION" | grep -q "SNAPSHOT" ; then
	echo "It is a snapshot"
#echo "repo=snapshots" >> /tmp/auto/release-$app.txt
	export repo=snapshots
	export wdir=/data/nexus/storage/$repo/
	echo "$wdir"
	echo "$repo"
	/bin/bash /usr/local/sbin/reporemove.sh
	/bin/bash /usr/local/sbin/repoadd.sh
else
#echo "repo=releases" >> /tmp/auto/release-$app.txt
	export repo=releases
	export wdir=/data/nexus/storage/$repo/`
#source /tmp/auto/release-$app.txt
	echo "The wdir is :$wdir"
	echo "the repo is :$repo"
	/bin/bash /usr/local/sbin/reporemove.sh
	/bin/bash /usr/local/sbin/repoadd.sh
fi

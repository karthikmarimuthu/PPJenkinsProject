#To get releases from pom.xml use either of the following commands.
REL=$(for i in $(grep '<version>' pom.xml); do ver=${i%<*}; ver=${ver#*>}; echo "$ver"; done | head -1)
echo $REL
REL=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')

echo $REL

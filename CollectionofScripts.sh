#To check pattern match

if echo "$string" | grep -q "My"; then
    echo "It's there!"
fi

# Find all files older than one day and delete

find /tmp/auto/ -mtime +1 -exec rm -f {} \;
#Find and delete all .svn directories
find . -name ".svn" -exec rm -r "{}" \;

# Find the latest modified file from a directory
<-- find . -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "
For a huge tree, it might be hard for sort to keep everything in memory.

%T@ gives you the modification time like a unix timestamp, sort -n sorts numerically, tail -1 takes the last line (highest timestamp), cut -f2 -d" " cuts away the first field (the timestamp) from the output.

Edit: Just as -printf is probably GNU-only, ajreals usage of stat -c is too. Although it is possible to do the same on BSD, the options for formatting is different (-f "%m %N" it would seem)

And I missed the part of plural; if you want more then the latest file, just bump up the tail argument. -->

#Match exact pattern and grep the latest modified file.

find . -type f -printf '%T@ %p\n' | sort -n | grep ".deb$" | cut -f2- -d" " | tail -1

#find pattern and keep only the contents between

sed -n '/ISA/,/IEA/p; /IEA/q' | sed 's/mule-app-accept-amazon-cc-parcel-2.1.0.log-//g' | sed 's/^.*ISA/ISA/'

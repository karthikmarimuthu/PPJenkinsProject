#To check pattern match

if echo "$string" | grep -q "My"; then
    echo "It's there!"
fi

# Find all files older than one day and delete

find /tmp/auto/ -mtime +1 -exec rm -f {} \;

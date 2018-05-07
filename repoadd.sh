#!/bin/bash
newf=$(find "$wdir" -type f -printf '%T@ %p\n' | sort -n | grep ".deb$" | cut -f2- -d" " | tail -1)
newfile=$(echo $newf | sed 's_/.nexus/attributes/_/_g')
#file=$(basename $newfile)
if [[ "$file" == *.deb ]];
        then
               # repo=$(get_repo $pkg)
                echo "Adding file: $newfile in repo: $repo"
                sudo aptly repo add $repo $newfile
                sudo aptly publish update -batch=true -keyring="/root/.gnupg/pubring.gpg" -secret-keyring="/root/.gnupg/secring.gpg" -gpg-key="3B5F5502" -passphrase="mGvV87Uo3av+5ZuRm3aiAIxo8IWoah" $repo
        else
                echo "file: "$newfile" is not a valid .deb file, skipping"
        fi

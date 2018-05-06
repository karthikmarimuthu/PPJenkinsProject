#!/bin/bash
newfile=$(find "$wdir" -type f -printf '%T@ %p\n' | sort -n | grep ".deb$" | cut -f2- -d" " | tail -1)
file=$(basename $newfile)
if [[ "$file" == *.deb ]];
        then
                repo=$(get_repo $pkg)
                echo "Adding file: $pkg in repo: $repo"
                aptly repo add $repo $pkg
                aptly publish update -batch=true -keyring="/root/.gnupg/pubring.gpg" -secret-keyring="/root/.gnupg/secring.gpg" -gpg-key="3B5F5502" -
passphrase="mGvV87Uo3av+5ZuRm3aiAIxo8IWoah" $repo
        else
                echo "file: "$pkg" is not a valid .deb file, skipping"
        fi

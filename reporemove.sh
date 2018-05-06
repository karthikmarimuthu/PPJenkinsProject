#!/bin/bash
#Removing package from the repo
        #pkg="$1"
        #file=$(basename $pkg)
        newfile=$(find "$wdir" -type f -printf '%T@ %p\n' | sort -n | grep ".deb$" | cut -f2- -d" " | tail -1)
        file=$(basename $newfile)
        if [[ "$file" == *.deb ]]
        then
                #repo=$(get_repo $pkg)
                PKG_VERSION=$(grep -B 2 "$file" /data/aptly/public/dists/$repo/main/binary-amd64/Packages | grep Version | sed "s/Version: //")
                #PKG_NAME=$(echo $file | sed "s/-[0-9].[0-9].*//")
                PKG_NAME=$(grep -B 8 "notification-service-1.0.0-20180430.043803-33.deb" /data/aptly/public/dists/$repo/main/binary-amd64/Packages |
grep Package | sed "s/Package: //")
                aptly repo remove $repo "$PKG_NAME ($PKG_VERSION)"
                aptly db cleanup
                aptly publish update -batch=true -keyring="/root/.gnupg/pubring.gpg" -secret-keyring="/root/.gnupg/secring.gpg" -gpg-key="3B5F5502" -
passphrase="mGvV87Uo3av+5ZuRm3aiAIxo8IWoah" $repo
        fi

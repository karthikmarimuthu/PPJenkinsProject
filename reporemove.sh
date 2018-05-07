#!/bin/bash
echo "Check and remove if package exists from the repo"
        #pkg="$1"
        #file=$(basename $pkg)
        newf=$(find "$wdir" -type f -printf '%T@ %p\n' | sort -n | grep ".deb$" | cut -f2- -d" " | tail -1)
        newfile=$(echo $newf | sed 's_/.nexus/attributes/_/_g')
        file=$(basename $newfile)
        if [[ "$file" == *.deb ]]
        then
                #repo=$(get_repo $pkg)
                PKG_VERSION=$(grep -B 2 "$file" /data/aptly/public/dists/$repo/main/binary-amd64/Packages | grep Version | sed "s/Version: //")
                #PKG_NAME=$(echo $file | sed "s/-[0-9].[0-9].*//")
                PKG_NAME=$(grep -B 8 "$file" /data/aptly/public/dists/$repo/main/binary-amd64/Packages | grep Package | sed "s/Package: //")
                sudo aptly repo remove $repo "$PKG_NAME ($PKG_VERSION)"
                sudo aptly db cleanup
                sudo aptly publish update -batch=true -keyring="/root/.gnupg/pubring.gpg" -secret-keyring="/root/.gnupg/secring.gpg" -gpg-key="3B5F5502" -passphrase="mGvV87Uo3av+5ZuRm3aiAIxo8IWoah" $repo
        fi

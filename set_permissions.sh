#!/usr/bin/env sh

# Setting File permissions
xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c ./*

if [ ! -d "$(pwd)/data/redis" ]; then
    mkdir -p "$(pwd)/data/redis"
fi

#if [ ! -d "$(pwd)/src/html" ]; then
#    mkdir -p "$(pwd)/src/html"
#fi

find "$(pwd)" -type d -exec chmod ugo=rwx {} \;
find "$(pwd)" -type f -exec chmod ugo=wr {} \;
find "$(pwd)" -type f \( -iname \*.sh -o -iname \*.py \) -exec chmod ugo+x {} \;

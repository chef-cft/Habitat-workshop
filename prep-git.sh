#!/bin/bash

cd ~/
git clone "http:///administrator:habworkshop@172.31.54.8:3000/administrator/hab-application.git"

echo "#####################"

cd hab-application
git config user.name "administrator"
git config user.email "training@chef.io"
rm README.md
dt=$(date)
echo "running a build from the workshop" > README.md
echo "$dt" >> README.md

git add .
git commit -m "Changed from the workshop"
git push origin


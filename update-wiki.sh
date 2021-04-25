#!/bin/sh

TEMP_WIKI_FOLDER="temp_wiki_$GITHUB_SHA"

#Get commit details
author=`git log -1 --format="%an"`
email=`git log -1 --format="%ae"`
message=`git log -1 --format="%s"`

#Clone wiki repo
git clone https://github.com/$GITHUB_REPO.wiki.git $TEMP_WIKI_FOLDER

#Copy edited wiki 
cp -r $1/. $TEMP_WIKI_FOLDER

#Check if wiki has changes
cd $TEMP_WIKI_FOLDER
if git diff-index --quiet HEAD; then
  echo "Nothing changed"
  return
fi

#Setup git and push
git config --local user.email $author
git config --local user.name $email
git add .
git commit -m "$message" && git push

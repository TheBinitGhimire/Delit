#!/bin/bash

function Write-Help {
  printf "
    %%# Delit - Delete everything from anyone's repositories on GitHub!
    %%# Author: Binit Ghimire <thebinitghimire@gmail.com>
    %%# Repository: https://github.com/TheBinitGhimire/Delit

    %%# Usage:
    .\delit.ps1 [branch] [User Name] [User Email] [Forked Repository]

    %%# Example:
    .\delit.ps1 main \"Binit Ghimire\" \"thebinitghimire@gmail.com\" \"git@github.com:TheBinitGhimire/Delit.git\"

    %%# How to find user's email?
      1. Visit the user's target repository,
      2. View the commit history,
      3. Click on one of the commit hashes,
      4. Modify the URL by appending \".patch\" to the end, and visit the modified URL!

      Now, you will be able to find out the user's email address there.\n
  "
}

function Write-Something {
  local type="$1"; # 0 for Message, 1 for Steps
  if [ $type = "0" ]; then
    printf "\n    %%# $2\n\n"
  else
    printf "\n    -> $2\n\n"
  fi
}

if [ $# -eq 0 ]; then
  Write-Help
  exit 1
fi

Write-Something 1 "Initializing!"

if [ $# -ne 4 ]; then
  Write-Something 0 "You haven't provided the required number of arguments."
  Write-Help
  exit 1
fi

Write-Something 0 "Provided Information:"
printf "
        %%# Branch: $1\n
        %%# User Name: $2\n
        %%# User Email: $3\n
        %%# Forked Repository: $4\n\n"

read -n1 -p $'\n    %# Is this information fine? (press \"y\" to continue): ' argsChecker
printf "\n"
if [[ $argsChecker != "y" ]]; then
  Write-Something 0 "Please try again with proper information!"
  exit 1
fi

gitChecker=$(git --version)
if [[ $gitChecker != "git version"* ]]; then
  Write-Something 0 "git isn't installed."
  exit 1
fi

Write-Something 0 "Everything seems fine."

initialDirectory=$(pwd)
localDirectory="delit-$(date +%s)"

Write-Something 1 "Checking the repository!"
if ! git ls-remote $4 &>/dev/null; then
  Write-Something 0 "There was an error while processing this repository."
  exit 1
fi

mkdir $localDirectory >/dev/null 2>&1
if [ ! -d "$localDirectory" ]; then
  Write-Something 0 "There was an error while creating a local directory."
  exit 1
fi

cd $localDirectory

Write-Something 1 "Initializing a local git repository!"
git init >/dev/null 2>&1

Write-Something 1 "Setting local git config variables!"
git config --local user.name $2
git config --local user.email $3

Write-Something 1 "Performing the required activities!"
printf "# I have deleted everything.\n## Thank you for visiting\x21\n[//]: # (Performed using https://github.com/TheBinitGhimire/Delit)" > README.md
git add .
git commit -m "Deleted everything!" >/dev/null 2>&1
git branch -M $1
git remote add origin $4

Write-Something 1 "Pushing to origin!"
git push -f origin $1 >/dev/null 2>&1
cd $initialDirectory

Write-Something 1 "Deleting the local repository!"
rm -rf $localDirectory

printf "\n
    %%# All processes completed!\n
    %%# If nothing wrong occured, the task must have been successful by now!\n
    %%# Thank You for using this tiny utility!\n\n
"
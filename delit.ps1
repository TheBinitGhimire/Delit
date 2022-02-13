function Write-Help {
  Write-Output "
    %# Delit - Delete everything from anyone's repositories on GitHub!
    %# Author: Binit Ghimire <thebinitghimire@gmail.com>
    %# Repository: https://github.com/TheBinitGhimire/Delit

    %# Usage:
    .\delit.ps1 [branch] [User Name] [User Email] [Forked Repository]

    %# Example:
    .\delit.ps1 main `"Binit Ghimire`" `"thebinitghimire@gmail.com`" `"git@github.com:TheBinitGhimire/Delit.git`"

    %# How to find user's email?
      1. Visit the user's target repository,
      2. View the commit history,
      3. Click on one of the commit hashes,
      4. Modify the URL by appending `".patch`" to the end, and visit the modified URL!

      Now, you will be able to find out the user's email address there.
  "  
}

function Write-Something {
  param (
    [switch] $type, # false for Message, true for Steps
    $strings
  )
  if (-Not $type) {
    Write-Output "`n    %# ${strings}`n"
  }
  else {
    Write-Output "`n    -> ${strings}`n"
  }
}

if ($args.Count.Equals(0)) {
  Write-Help
  Exit
}

Write-Something -type 1 -strings "Initializing!"

if (-Not $args.Count.Equals(4)) {
  Write-Something -strings "You haven't provided the required number of arguments."
  Write-Help
  Exit
}

Write-Something "Provided Information:"
Write-Output "
        %# Branch: $($args[0])`n
        %# User Name: $($args[1])`n
        %# User Email: $($args[2])`n
        %# Forked Repository: $($args[3])`n"

$argsChecker = Read-Host -Prompt "`n    %# Is this information fine? (press `"y`" to continue)"
if (-Not $argsChecker.Equals("y")) {
  Write-Something -strings "Please try again with proper information!"
  Exit
}

$gitChecker = (git --version) -join "`n"
if (-Not $gitChecker.StartsWith("git version")) {
  Write-Something -strings "git isn't installed."
  Exit
}

Write-Something -strings "Everything seems fine."

$initialDirectory = (Get-Location)
$localDirectory = "delit-$(Get-Random)"

Write-Something -type 1 -strings "Checking the repository!"
if(-Not (git ls-remote $args[3] 2>$null)) {
  Write-Something -strings "There was an error while processing this repository."
  Exit
}

New-Item -Path $localDirectory -ItemType Directory >$null 2>&1
if(-Not (Test-Path -Path $localDirectory)) {
  Write-Something -strings "There was an error while creating a local directory."
  Exit
}

Set-Location $localDirectory

Write-Something -type 1 -strings "Initializing a local git repository!"
git init >$null 2>&1

Write-Something -type 1 -strings "Setting local git config variables!"
git config --local user.name $args[1]
git config --local user.email $args[2]

Write-Something -type 1 -strings "Performing the required activities!"
Write-Output "# I have deleted everything.`n## Thank you for visiting!`n[//]: # (Performed using https://github.com/TheBinitGhimire/Delit)" > README.md
git add .
git commit -m "Deleted everything!" >$null 2>&1
git branch -M $args[0]
git remote add origin $args[3]

Write-Something -type 1 -strings "Pushing to origin!"
git push -f origin $args[0] >$null 2>&1
Set-Location $initialDirectory

Write-Something -type 1 -strings "Deleting the local repository!"
Remove-Item -r -fo $localDirectory

Write-Output "`n
    %# All processes completed!`n
    %# If nothing wrong occured, the task must have been successful by now!`n
    %# Thank You for using this tiny utility!`n
"
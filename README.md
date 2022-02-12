# Delit
## Delete everything from anyone's repositories on GitHub!

## Usage

```powershell
.\delit.ps1 [branch] [User Name] [User Email] [Forked Repository]
```

After using **Delit**, do the following:
1. Visit the forked repository,
2. View the commit history,
3. Click on the commit hash next to the one and only commit,
4. Replace your username in the URL with the target user's username,
5. Visit the modified URL!

Now, you will be able to see the commit created with this project in the target user's repository. You may also click on "**Browse files**" to see the changes in action.

## Example

```powershell
.\delit.ps1 main "Binit Ghimire" "thebinitghimire@gmail.com" "git@github.com:TheBinitGhimire/Delit.git"
```

## How to find user's email?

1. Visit the user's target repository,
2. View the commit history,
3. Click on one of the commit hashes,
4. Modify the URL by appending "**`.patch`**" to the end, and visit the modified URL!

Now, you will be able to find out the user's email address there.

## Usage Scenario
### torvalds/linux
* Original Repository: https://github.com/torvalds/linux
* Forked Repository: https://github.com/TheBinitGhimire/linux

* Commit in Forked Repository: https://github.com/TheBinitGhimire/linux/commit/79a2cc1251956586e7d102e138f4b5e9c6a22b39
* Commit in Original Repository: https://github.com/torvalds/linux/commit/79a2cc1251956586e7d102e138f4b5e9c6a22b39

## Images
### Repository
![torvalds/linux](images/repository.png)

### Open Graph Image
![79a2cc1251956586e7d102e138f4b5e9c6a22b39](images/commit.png)
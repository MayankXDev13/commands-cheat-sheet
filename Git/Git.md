# Git & GitHub Complete Setup Guide (Ubuntu/Linux)

This guide walks you through installing Git, configuring it, and
connecting your local projects to GitHub using HTTPS or SSH.

------------------------------------------------------------------------

## Step 1: Install Git

Check if Git is installed:

``` bash
git --version
```

If not installed:

``` bash
sudo apt update
sudo apt install git -y
```

Verify installation:

``` bash
git --version
```

------------------------------------------------------------------------

## Step 2: Configure Git

Set your global username and email:

``` bash
git config --global user.name "MayankXDev13"
git config --global user.email "youremail@example.com"
git config --global credential.helper store
```

Verify configuration:

``` bash
git config --list
```

------------------------------------------------------------------------

# METHOD 1: HTTPS Setup

## Step 3A: Generate Personal Access Token (PAT)

1.  Go to: https://github.com/settings/tokens\
2.  Click **Fine-grained personal access tokens → Generate new token**
3.  Select Repository access → All repositories
4.  Set permissions:
    -   Contents → Read & Write\
    -   Metadata → Read-only
5.  Click Generate Token
6.  Copy the token (you will use it as password)

------------------------------------------------------------------------

## Step 4A: Connect Local Repository

``` bash
git remote add origin https://github.com/MayankXDev13/repository.git
git remote -v
```

------------------------------------------------------------------------

## Step 5A: Push Code

``` bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

When prompted:

Username: MayankXDev13\
Password: `<paste your PAT>`{=html}

------------------------------------------------------------------------

# METHOD 2: SSH Setup

## Step 3B: Generate SSH Key

``` bash
ssh-keygen -t ed25519 -C "youremail@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

------------------------------------------------------------------------

## Step 4B: Add SSH Key to GitHub

``` bash
cat ~/.ssh/id_ed25519.pub
```

1.  Copy the output
2.  Go to: https://github.com/settings/keys
3.  Click New SSH Key
4.  Paste the key and Save

Test connection:

``` bash
ssh -T git@github.com
```

------------------------------------------------------------------------

## Step 5B: Switch Remote to SSH

``` bash
git remote set-url origin git@github.com:MayankXDev13/repository.git
git remote -v
git push
```

------------------------------------------------------------------------

# Push Existing Local Project

``` bash
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:MayankXDev13/repository.git
git push -u origin main
```

------------------------------------------------------------------------

# Verify Last Commit

``` bash
git log -1
```

Open in browser:

``` bash
git log -1 --format="https://github.com/MayankXDev13/repository/commit/%H" | xargs xdg-open
```

------------------------------------------------------------------------

# Useful Git Commands

-   Check remotes: `git remote -v`
-   Change remote URL: `git remote set-url origin <new-url>`
-   Pull latest changes: `git pull origin main`
-   View last commit: `git log -1`
-   Check branch: `git branch`
-   Switch branch: `git checkout <branch>`

------------------------------------------------------------------------

Notes:

-   Replace MayankXDev13 and repository with your actual GitHub username
    and repository name.
-   Use main or master depending on your branch.
-   SSH is recommended for long-term use.
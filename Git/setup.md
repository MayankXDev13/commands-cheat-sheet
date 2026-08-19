# Git & GitHub Setup

## Configure Git And Github

> Set your global user name and email.

```bash
git config --global user.name "MayankXDev13"
git config --global user.email "[EMAIL_ADDRESS]"
git config --global credential.helper store
```

> Verify configuration

```bash
git config --list
```

## Login to GitHub

### Method 1: HTTPS (Generate Personal Access Token)

1.  Go to: https://github.com/settings/personal-access-tokens
2.  Click **Fine-grained personal access tokens → Generate new token**
3.  Select Repository access → All repositories
4.  Set permissions:
    - Contents → Read & Write\
    - Metadata → Read-only
5.  Click Generate Token
6.  Copy the token (you will use it as password)

> Connect local repository to GitHub

```bash
git remote add origin <repository-url>
git remote -v
```

> Push code to GitHub

```bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

When prompted:
Username: MayankXDev13 \
Password: `<paste your PAT>`

### Method 2: SSH (Generate SSH Key)

> Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

> Add SSH key to GitHub

```bash
cat ~/.ssh/id_ed25519.pub
```

1.  Copy the output
2.  Go to: https://github.com/settings/keys
3.  Click New SSH Key
4.  Paste the key and Save

Test connection:

```bash
ssh -T git@github.com
```

> Switch Remote to SSH

```bash
git remote set-url origin git@github.com:MayankXDev13/repository.git
git remote -v
git push
```

> Push Existing Local Project

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:MayankXDev13/repository.git
git push -u origin main
```

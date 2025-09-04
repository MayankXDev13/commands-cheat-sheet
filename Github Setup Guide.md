# GitHub Configuration Guide

This guide helps you set up Git and GitHub on your system (Ubuntu/Linux).

---

## **Step 1: Install Git**

Check if Git is installed:

```bash
git --version
```

If Git is not installed, install it:

```bash
sudo apt update
sudo apt install git -y
```

---

## **Step 2: Configure Git**

Set your Git username and email:

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

Verify configuration:

```bash
git config --list
```

---

## **Step 3: Generate SSH Key**

Generate a new SSH key for GitHub:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

- Press Enter to accept default file location.
- Optionally, set a passphrase.

Start the SSH agent and add your key:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Copy your SSH public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## **Step 4: Add SSH Key to GitHub**

1. Go to GitHub → **Settings → SSH and GPG keys → New SSH key**.
2. Paste the copied SSH key and save.

Test the SSH connection:

```bash
ssh -T git@github.com
```

Expected output:

```
Hi username! You've successfully authenticated.
```

---

## **Step 5: Clone a Repository**

```bash
git clone git@github.com:username/repository.git
```

---

## **Step 6: Push Local Project to GitHub**

1. Initialize Git in your project folder:

```bash
git init
```

2. Add files:

```bash
git add .
```

3. Commit changes:

```bash
git commit -m "Initial commit"
```

4. Add remote repository:

```bash
git remote add origin git@github.com:username/repository.git
```

5. Push changes:

```bash
git push -u origin main
```

---

## **Notes**

- Replace `username` and `repository` with your GitHub username and repo name.
- Use `main` or `master` branch as per your repo.
- SSH keys are more secure than HTTPS for GitHub authentication.

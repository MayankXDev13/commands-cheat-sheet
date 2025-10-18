# 🚀 Git + GitHub Setup Guide

[![GitHub](https://img.shields.io/badge/GitHub-Setup-blue?logo=github\&style=flat-square)](https://github.com)
Easily set up your local project to push code to GitHub using **HTTPS** or **SSH**.

---

## 🧠 Step 1: Configure Git

```bash
git config --global user.name "MayankXDev13"
git config --global user.email "youremail@example.com"
git config --global credential.helper store
```

> 💡 Stores your GitHub credentials securely and links your commits to your account.

---

## 🔑 Step 2: HTTPS Setup (Beginner-Friendly)

### 1️⃣ Generate a Personal Access Token (PAT)

1. Go to 👉 [GitHub Tokens](https://github.com/settings/tokens)
2. Click **“Fine-grained personal access tokens” → Generate new token**
3. Repository access: ✅ **All repositories**
4. Repository permissions:

   * ✅ Contents → Read and Write
   * ✅ Metadata → Read-only
5. Click **Generate token** and copy it (you’ll use this as password in Git).

---

### 2️⃣ Connect Local Repo

```bash
git remote add origin https://github.com/MayankXDev13/sql-agent.git
git remote -v
```

---

### 3️⃣ Push Code

```bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

When prompted:

```
Username: MayankXDev13
Password: <paste your PAT>
```

✅ Your code is now on GitHub! 🎉

---

## 🔐 Step 3: SSH Setup (Password-Free)

### 1️⃣ Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "youremail@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

---

### 2️⃣ Add SSH Key to GitHub

```bash
cat ~/.ssh/id_ed25519.pub
```

1. Copy the output
2. Go to [GitHub SSH Keys](https://github.com/settings/keys) → **New SSH key** → Paste → Save

---

### 3️⃣ Switch Remote to SSH

```bash
git remote set-url origin git@github.com:MayankXDev13/sql-agent.git
git remote -v
```

---

### 4️⃣ Push Code

```bash
git add .
git commit -m "SSH setup"
git push
```

✅ No username or password needed.

---

## 🧾 Step 4: Verify Last Commit

Show latest commit:

```bash
git log -1
```

Open in browser:

```bash
git log -1 --format="https://github.com/MayankXDev13/sql-agent/commit/%H" | xargs xdg-open
```

---

## 🧰 Bonus Commands

| Purpose             | Command                               |
| ------------------- | ------------------------------------- |
| Check remotes       | `git remote -v`                       |
| Change remote URL   | `git remote set-url origin <new-url>` |
| Pull latest changes | `git pull origin main`                |
| View last commit    | `git log -1`                          |
| Check branch        | `git branch`                          |
| Switch branch       | `git checkout <branch>`               |

---

## ✨ Pro Tip

Make an alias to quickly open your last commit:

```bash
git config --global alias.viewlast '!git log -1 --format="https://github.com/MayankXDev13/sql-agent/commit/%H" | xargs xdg-open'
```

Now just run:

```bash
git viewlast
```

---

**Made with 💻 by [MayankXDev13](https://github.com/MayankXDev13)**
Simplifying Git setups for yourself and your team!

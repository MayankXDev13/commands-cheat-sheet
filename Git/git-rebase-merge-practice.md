# Practice Git Rebasing and Merging Feature Branches

This guide provides a hands-on practice workflow for understanding the difference between **Git merge** and **Git rebase**.

---

## 1. Create a Practice Repository

```bash
mkdir git-rebase-practice
cd git-rebase-practice

git init
```

Create the initial file:

```bash
echo "# Git Practice" > README.md
```

Commit it:

```bash
git add README.md
git commit -m "chore: initial commit"
```

Create another commit on `main`:

```bash
echo "Main branch work" >> README.md

git add README.md
git commit -m "docs: update README"
```

Check the history:

```bash
git log --oneline --graph --all
```

---

# 2. Create a Feature Branch

Create and switch to a feature branch:

```bash
git switch -c feature/login
```

Make the first feature commit:

```bash
echo "Login feature" > login.txt

git add login.txt
git commit -m "feat: add login"
```

Make another feature commit:

```bash
echo "Login validation" >> login.txt

git add login.txt
git commit -m "feat: add login validation"
```

The history now looks like:

```text
main
  |
  A---B
               C---D feature/login
```

---

# Part A — Practice Git Merge

Switch back to `main`:

```bash
git switch main
```

Make a new commit on `main`:

```bash
echo "Main branch update" >> README.md

git add README.md
git commit -m "docs: add main branch update"
```

The history is now:

```text
        C---D feature/login
       /
A---B---E main
```

Merge the feature branch:

```bash
git merge feature/login
```

The history may now look like:

```text
        C---D
       /     A---B---E-----M main
```

`M` is the merge commit.

Check the history:

```bash
git log --oneline --graph --all
```

---

# Part B — Practice Git Rebase

Create another feature branch:

```bash
git switch -c feature/profile
```

Make the first feature commit:

```bash
echo "Profile feature" > profile.txt

git add profile.txt
git commit -m "feat: add profile"
```

Make another feature commit:

```bash
echo "Profile validation" >> profile.txt

git add profile.txt
git commit -m "feat: validate profile"
```

Switch to `main`:

```bash
git switch main
```

Create another commit on `main`:

```bash
echo "Another main change" >> README.md

git add README.md
git commit -m "docs: update documentation"
```

The history is now:

```text
        C---D feature/profile
       /
A---B---E---F main
```

---

## 3. Rebase the Feature Branch

Switch back to the feature branch:

```bash
git switch feature/profile
```

Rebase it onto `main`:

```bash
git rebase main
```

Git takes the feature commits and reapplies them on top of the latest `main`.

Before:

```text
        C---D feature/profile
       /
A---B---E---F main
```

After:

```text
A---B---E---F---C'---D'
                    ^
                    feature/profile
```

`C'` and `D'` represent new commits created by the rebase.

Check the history:

```bash
git log --oneline --graph --all
```

---

# 4. Merge the Rebasing Feature Branch

Switch to `main`:

```bash
git switch main
```

Merge the rebased branch:

```bash
git merge feature/profile
```

Because the feature branch is directly ahead of `main`, Git can perform a **fast-forward merge**.

The final history looks like:

```text
A---B---E---F---C'---D'
                    ^
                    main
```

No additional merge commit is required.

---

# Merge vs Rebase

## Merge

Command:

```bash
git switch main
git merge feature/login
```

Merge preserves the branching history:

```text
      C---D
     /     A---B---E---M
```

### Advantages

- Does not rewrite existing commits.
- Safe for shared branches.
- Preserves the true branch history.
- Easy to use when multiple developers are working on the same branch.

---

## Rebase

Command:

```bash
git switch feature/login
git rebase main
```

Rebase creates a linear history:

```text
A---B---E---C'---D'
```

### Advantages

- Produces a clean, linear history.
- Makes project history easier to read.
- Avoids unnecessary merge commits.

### Important Warning

Rebase rewrites commit history.

Avoid rebasing a branch that other developers are already using unless your team explicitly agrees.

---

# Useful Git Commands

## View branches

```bash
git branch
```

## View all branches

```bash
git branch -a
```

## Switch branches

```bash
git switch main
```

## Create and switch to a branch

```bash
git switch -c feature/navbar
```

## View commit history

```bash
git log --oneline
```

## View graphical history

```bash
git log --oneline --graph --decorate --all
```

## Check working tree

```bash
git status
```

## Fetch remote changes

```bash
git fetch origin
```

## Update local main

```bash
git switch main
git pull origin main
```

## Rebase feature onto main

```bash
git switch feature/navbar
git rebase main
```

## Merge feature into main

```bash
git switch main
git merge feature/navbar
```

---

# Rebase Conflict Practice

Conflicts are an important part of learning rebase.

Start a rebase:

```bash
git switch feature/navbar
git rebase main
```

If Git reports a conflict:

```bash
git status
```

Open the conflicted file and resolve the conflict.

Then:

```bash
git add <file>
git rebase --continue
```

If another conflict occurs, resolve it and repeat:

```bash
git add <file>
git rebase --continue
```

To cancel the entire rebase:

```bash
git rebase --abort
```

---

# Merge Conflict Practice

Start a merge:

```bash
git switch main
git merge feature/navbar
```

If a conflict occurs:

```bash
git status
```

Resolve the conflicted files.

Then:

```bash
git add <file>
git commit
```

To cancel the merge:

```bash
git merge --abort
```

---

# Practice Workflow

Use this workflow repeatedly until it becomes familiar:

```bash
# Start from main
git switch main

# Create feature branch
git switch -c feature/navbar

# Make feature commits
git add .
git commit -m "feat: add navbar"

git add .
git commit -m "feat: improve navbar"

# Return to main
git switch main

# Make independent main changes
git add .
git commit -m "docs: update documentation"

# Rebase feature onto main
git switch feature/navbar
git rebase main

# Merge feature into main
git switch main
git merge feature/navbar

# Inspect history
git log --oneline --graph --decorate --all
```

---

# Key Interview Question

### What is the difference between merge and rebase?

**Merge** combines two branches and normally creates a merge commit when the histories have diverged.

**Rebase** moves/replays the feature branch commits on top of another branch, creating a cleaner linear history but rewriting commit history.

A simple way to remember:

```text
Merge:
preserve history

Rebase:
rewrite history + linearize history
```

## Golden Rule

> **Merge is safer for shared history. Rebase is useful for cleaning up your own feature branch before merging.**

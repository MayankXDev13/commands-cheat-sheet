# Git & GitHub

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

## Git Command

### View Git History Graph

```bash
git log --oneline --all --graph
```

### Abort a Cherry-Pick

```bash
git cherry-pick --abort
```

### Git Reset Explanation

-   **git reset** → moves the current branch pointer.
-   **--hard** → resets commit + staging area + working directory.
-   **HEAD~3** → moves the branch 3 commits back.

```bash
git reset --hard HEAD~3
```

## Git Branch Guide: Creating Branches and Fixing Commits in the Wrong Branch

### Create and Switch to a New Branch

To create a new branch and switch to it at the same time:

```bash
git checkout -b <branch-name>
```

Example:

```bash
git checkout -b feature
```

This creates the branch `feature` and switches to it.

### Switch to an Existing Branch

```bash
git checkout <branch-name>
```

Example:

```bash
git checkout main
```

### Problem: You Committed Code in the Wrong Branch

Example situation:

You were supposed to:

1.  Create a branch `feature`
2.  Implement **login integration**
3.  Commit the code in the `feature` branch

But you accidentally committed the code in the **`main` branch**.

### Recommended Solution (Cherry‑pick First, Then Reset)

A safer and clearer workflow is:

1.  Copy the commit to the correct branch using **cherry‑pick**
2.  Clean the `main` branch by resetting it

#### Step 1 --- Check commit history

```bash
git log --oneline
```

Example:

    a3f45c1 Add login integration
    9bd1234 Update UI
    5fa2221 Initial commit

Note the **commit hash** you want to move.

#### Step 2 --- Create or switch to the feature branch

Create the branch if it doesn't exist:

```bash
git checkout -b feature
```

or switch to it if it already exists:

```bash
git checkout feature
```

#### Step 3 --- Cherry‑pick the commit

Copy the commit from `main` into the `feature` branch:

```bash
git cherry-pick <commit-id>
```

Example:

```bash
git cherry-pick a3f45c1
```

Now the commit exists in the **feature branch**.

#### Step 4 --- Switch back to main

```bash
git checkout main
```

#### Step 5 --- Remove the wrong commit from main

Reset `main` to the commit before the feature work:

```bash
git reset --hard HEAD~1
```

or reset to a specific commit:

```bash
git reset --hard <commit-id>
```

Example:

```bash
git reset --hard 9bd1234
```

#### Result

Before fixing:

    main
     ├── commit A
     ├── commit B
     └── login integration ❌

After fixing:

    main
     ├── commit A
     └── commit B

    feature
     └── login integration ✅

#### Why This Approach Is Better

-   Prevents losing commits
-   Keeps the `main` branch clean
-   Safer when working with teams
-   Works even when commits are already created in the wrong branch

#### Typical Developer Workflow (Best Practice)

    main
      │
      ├── create feature branch
      │
    feature/login
      │
      ├── develop feature
      ├── commit changes
      ├── push branch
      │
    Pull Request → Review → Merge into main

Following this workflow helps avoid committing features directly to the
`main` branch.

## Recovering a Deleted Git Feature Branch Using Reflog

### Scenario

You were given a task to integrate a payment gateway and create a
webhook in a project.

You created a new branch and started working on the feature.

```bash
git checkout -b feature/payment
```

You implemented the payment gateway integration and completed your work.

The next morning you thought you had already raised a Pull Request (PR)
and that it was merged into the `main` branch.

So you switched to the main branch and deleted the feature branch.

```bash
git checkout main
git branch -d feature/payment
```

Later you realized that the PR was **never created** and the branch
containing your payment gateway work was deleted.

Now the question is: **How do you recover the deleted branch?**

### Solution: Using Git Reflog

Git keeps a history of all HEAD movements using **reflog**, which allows
you to recover lost commits or deleted branches.

#### Step 1: Check Git Reflog

Run:

```bash
git reflog
```

You will see entries similar to:

    abc1234 HEAD@{0}: checkout: moving from main to main
    def5678 HEAD@{1}: checkout: moving from feature/payment to main
    ghi9012 HEAD@{2}: commit: added payment gateway integration

The important part is the commit reference like:

    HEAD@{1}

#### Step 2: Recreate the Deleted Branch

Once you find the correct reference, recreate the branch using:

```bash
git checkout -b feature/payment HEAD@{1}
```

This command:

-   Creates a new branch named `feature/payment`
-   Points it to the previous commit where your work existed

### Result

Your deleted branch is restored with all the payment gateway integration
code.

Now you can:

```bash
git push origin feature/payment
```

And create your **Pull Request normally**.

### Key Takeaway

Even if a branch is deleted, **Git Reflog acts like a safety net** and
allows you to recover commits and recreate branches easily.

Command to remember:

```bash
git reflog
git checkout -b <branch-name> <commit-reference>
```

Example:

```bash
git checkout -b feature/payment HEAD@{1}
```

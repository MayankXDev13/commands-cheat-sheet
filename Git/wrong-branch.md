# Git Branch Guide: Creating Branches and Fixing Commits in the Wrong Branch

## Create and Switch to a New Branch

To create a new branch and switch to it at the same time:

``` bash
git checkout -b <branch-name>
```

Example:

``` bash
git checkout -b feature
```

This creates the branch `feature` and switches to it.

------------------------------------------------------------------------

## Switch to an Existing Branch

``` bash
git checkout <branch-name>
```

Example:

``` bash
git checkout main
```

------------------------------------------------------------------------

# Problem: You Committed Code in the Wrong Branch

Example situation:

You were supposed to:

1.  Create a branch `feature`
2.  Implement **login integration**
3.  Commit the code in the `feature` branch

But you accidentally committed the code in the **`main` branch**.

------------------------------------------------------------------------

# Recommended Solution (Cherry‑pick First, Then Reset)

A safer and clearer workflow is:

1.  Copy the commit to the correct branch using **cherry‑pick**
2.  Clean the `main` branch by resetting it

------------------------------------------------------------------------

## Step 1 --- Check commit history

``` bash
git log --oneline
```

Example:

    a3f45c1 Add login integration
    9bd1234 Update UI
    5fa2221 Initial commit

Note the **commit hash** you want to move.

------------------------------------------------------------------------

## Step 2 --- Create or switch to the feature branch

Create the branch if it doesn't exist:

``` bash
git checkout -b feature
```

or switch to it if it already exists:

``` bash
git checkout feature
```

------------------------------------------------------------------------

## Step 3 --- Cherry‑pick the commit

Copy the commit from `main` into the `feature` branch:

``` bash
git cherry-pick <commit-id>
```

Example:

``` bash
git cherry-pick a3f45c1
```

Now the commit exists in the **feature branch**.

------------------------------------------------------------------------

## Step 4 --- Switch back to main

``` bash
git checkout main
```

------------------------------------------------------------------------

## Step 5 --- Remove the wrong commit from main

Reset `main` to the commit before the feature work:

``` bash
git reset --hard HEAD~1
```

or reset to a specific commit:

``` bash
git reset --hard <commit-id>
```

Example:

``` bash
git reset --hard 9bd1234
```

------------------------------------------------------------------------

# Result

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

------------------------------------------------------------------------

# Why This Approach Is Better

-   Prevents losing commits
-   Keeps the `main` branch clean
-   Safer when working with teams
-   Works even when commits are already created in the wrong branch

------------------------------------------------------------------------

# Typical Developer Workflow (Best Practice)

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

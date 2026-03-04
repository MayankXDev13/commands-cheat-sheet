# Recovering a Deleted Git Feature Branch Using Reflog

## Scenario

You were given a task to integrate a payment gateway and create a
webhook in a project.

You created a new branch and started working on the feature.

``` bash
git checkout -b feature/payment
```

You implemented the payment gateway integration and completed your work.

The next morning you thought you had already raised a Pull Request (PR)
and that it was merged into the `main` branch.

So you switched to the main branch and deleted the feature branch.

``` bash
git checkout main
git branch -d feature/payment
```

Later you realized that the PR was **never created** and the branch
containing your payment gateway work was deleted.

Now the question is: **How do you recover the deleted branch?**

------------------------------------------------------------------------

# Solution: Using Git Reflog

Git keeps a history of all HEAD movements using **reflog**, which allows
you to recover lost commits or deleted branches.

### Step 1: Check Git Reflog

Run:

``` bash
git reflog
```

You will see entries similar to:

    abc1234 HEAD@{0}: checkout: moving from main to main
    def5678 HEAD@{1}: checkout: moving from feature/payment to main
    ghi9012 HEAD@{2}: commit: added payment gateway integration

The important part is the commit reference like:

    HEAD@{1}

------------------------------------------------------------------------

### Step 2: Recreate the Deleted Branch

Once you find the correct reference, recreate the branch using:

``` bash
git checkout -b feature/payment HEAD@{1}
```

This command:

-   Creates a new branch named `feature/payment`
-   Points it to the previous commit where your work existed

------------------------------------------------------------------------

# Result

Your deleted branch is restored with all the payment gateway integration
code.

Now you can:

``` bash
git push origin feature/payment
```

And create your **Pull Request normally**.

------------------------------------------------------------------------

# Key Takeaway

Even if a branch is deleted, **Git Reflog acts like a safety net** and
allows you to recover commits and recreate branches easily.

Command to remember:

``` bash
git reflog
git checkout -b <branch-name> <commit-reference>
```

Example:

``` bash
git checkout -b feature/payment HEAD@{1}
```

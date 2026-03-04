# Git Notes

## View Git History Graph

    git log --oneline --all --graph

## Abort a Cherry-Pick

    git cherry-pick --abort

## Git Reset Explanation

-   **git reset** → moves the current branch pointer.
-   **--hard** → resets commit + staging area + working directory.
-   **HEAD\~3** → moves the branch 3 commits back.

### Command

    git reset --hard HEAD~3

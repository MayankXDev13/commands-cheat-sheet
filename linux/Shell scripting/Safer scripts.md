# Safer scripts

## What I learned

This chapter covered safer Bash scripting, handling filenames correctly,
strict mode, functions with local variables, and automatic cleanup with
`mktemp` and `trap`.

### 1. Handling filenames safely

Used `find` with `while IFS= read -r` to process filenames one complete
line at a time.

``` bash
find drafts -name '*.tmp' | while IFS= read -r f; do
    echo "[$f]"
done
```

Important components:

-   `find drafts -name '*.tmp'`: Finds files ending in `.tmp`.
-   `while`: Processes each filename separately.
-   `IFS=`: Prevents leading and trailing whitespace from being trimmed.
-   `read -r`: Reads the complete line and does not interpret
    backslashes.
-   `"$f"`: Keeps filenames containing spaces together.

Avoid this pattern for filenames:

``` bash
for f in $(find drafts -name '*.tmp'); do
    echo "[$f]"
done
```

Command substitution followed by word splitting breaks filenames
containing spaces.

### 2. Removing files safely

A filename beginning with `-` can be mistaken for a command option. Use
`--` to mark the end of command options.

``` bash
rm -- "$f"
```

-   `--` tells `rm` that the following argument is a filename, not an
    option.
-   `"$f"` preserves the complete filename, including spaces.

### 3. Using strict mode

Added strict mode immediately after the Bash shebang to make scripts
stop when important errors occur.

``` bash
#!/bin/bash
set -euo pipefail
```

Strict mode includes:

  -----------------------------------------------------------------------
  Option                              Description
  ----------------------------------- -----------------------------------
  `-e`                                Exits when a command fails, subject
                                      to Bash's conditional-command
                                      exceptions.

  `-u`                                Treats the use of an unset variable
                                      as an error.

  `-o pipefail`                       Makes a pipeline fail if any
                                      command in it fails.
  -----------------------------------------------------------------------

Example:

``` bash
#!/bin/bash
set -euo pipefail

cd "$1"
echo "Files in $(pwd):"
ls
```

If the directory does not exist, the script stops instead of continuing
in the previous directory.

### 4. Understanding `pipefail`

Without `pipefail`, a pipeline normally returns the exit status of its
last command.

``` bash
grep chai missing.txt | wc -l
```

Even if `grep` fails, `wc -l` can succeed and return `0`.

With `pipefail` enabled, the pipeline reports a failure if an earlier
command fails.

``` bash
set -o pipefail
grep chai missing.txt | wc -l
```

### 5. Creating functions and using `local`

A function is a named block of commands that can be called like a
command. Function arguments are available through `$1`, `$2`, and so on.

``` bash
greet() {
    local name=$1
    echo "Hello, $name"
}

greet Kabir
```

-   `greet()`: Defines a function.
-   `$1`: Receives the first argument passed to the function.
-   `local`: Keeps the variable local to the function.
-   `greet Kabir`: Calls the function with `Kabir` as its argument.

Without `local`, assigning to a variable inside a function can change
the variable used by the rest of the script.

### 6. Creating temporary files with `mktemp`

Used `mktemp` to create a unique temporary file instead of using a fixed
filename that could conflict with another script run.

``` bash
tmp=$(mktemp)
echo "Temporary file: $tmp"
```

-   `mktemp`: Creates a new temporary file and prints its path.
-   `$(...)`: Captures the command's output.
-   `tmp`: Stores the generated temporary file path.

### 7. Cleaning up with `trap`

Used `trap` with the `EXIT` signal to remove the temporary file whenever
the script exits, including when strict mode causes it to stop.

``` bash
#!/bin/bash
set -euo pipefail

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

ls "$1" > "$tmp"
echo "$(wc -l < "$tmp") names"
```

Important components:

-   `trap`: Registers a command to run when a specified event occurs.
-   `EXIT`: Runs the cleanup command when the script exits.
-   `rm -f "$tmp"`: Removes the temporary file without prompting and
    does not fail if it is already missing.
-   `"$tmp"`: Preserves the complete temporary file path.

### 8. Checking scripts before running

Used `bash -n` to check a script for syntax errors without executing it.

``` bash
bash -n clean-uploads.sh
```

Used `cat` to inspect the script contents.

``` bash
cat clean-uploads.sh
```

## Important commands practised

``` bash
find drafts -name '*.tmp' | while IFS= read -r f; do
    echo "[$f]"
done
```

``` bash
rm -- "$f"
```

``` bash
set -euo pipefail
```

``` bash
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
```

``` bash
bash -n clean-uploads.sh
```

## Key takeaways

1.  `find` locates files matching a name or pattern.
2.  `while IFS= read -r` processes filenames one complete line at a
    time.
3.  Avoid `for f in $(find ...)` because spaces in filenames can split
    them into separate words.
4.  `rm -- "$f"` safely handles filenames that begin with a dash.
5.  `set -euo pipefail` helps scripts stop when commands, variables, or
    pipelines fail.
6.  `-e` stops on command failures, with Bash conditional-command
    exceptions.
7.  `-u` treats unset variables as errors.
8.  `pipefail` makes a pipeline report failures from commands before the
    last one.
9.  Functions organize reusable commands, and `local` keeps variables
    inside a function.
10. `mktemp` creates a unique temporary file.
11. `trap 'rm -f "$tmp"' EXIT` cleans up the temporary file when the
    script exits.
12. `bash -n` checks syntax without running the script.

**Chapter 27: Safer scripts --- key concepts covered.**
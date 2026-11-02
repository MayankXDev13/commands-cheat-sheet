# Conditions and Exit Codes

## What I learned

This chapter covered Bash conditions, file checks, exit codes, and conditional command execution.

### 1. Understanding exit codes

Every command returns an exit code:

- `0` means success.
- Any non-zero number means failure.
- `$?` stores the exit code of the last executed command.

Example:

```bash
ls nothing.txt
echo $?
```

### 2. Checking files with test `[ ]`

| Condition | Description |
|---|---|
| `-f FILE` | Checks whether a regular file exists |
| `-d DIR` | Checks whether a directory exists |
| `-s FILE` | Checks whether a file exists and is not empty |
| `-z "$x"` | Checks whether a string is empty |
| `-n "$x"` | Checks whether a string is not empty |
| `!` | Reverses a condition |

Example:

```bash
[ -f stock.txt ]
echo $?

[ -s empty.txt ]
echo $?
```

### 3. Using if, exit and stderr

- `if` executes commands when a condition succeeds.
- `elif` checks another condition.
- `else` handles the remaining cases.
- `fi` closes the conditional block.
- `exit N` terminates the script with an exit code.
- `>&2` sends output to standard error.

Example:

```bash
if [ "$1" -lt 5 ]; then
    echo "Low: $1 litres" >&2
    exit 1
fi

echo "Milk OK: $1 litres"
```

### 4. Command substitution

Used `$( )` to capture the output of a command.

```bash
echo "Lines: $(wc -l < stock.txt)"
```

This prints the number of lines in the file.

### 5. Using && and ||

| Operator | Description |
|---|---|
| `&&` | Runs the next command only if the previous command succeeds |
| `||` | Runs the next command only if the previous command fails |

Example:

```bash
./milk.sh 3 && echo "no order needed" || echo "order milk"
```

## Final check-menu.sh script

```bash
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: check-menu.sh FILE"
    exit 2
fi

if [ ! -f "$1" ]; then
    echo "Missing: $1"
    exit 1
fi

if [ ! -s "$1" ]; then
    echo "Empty: $1"
    exit 1
fi

echo "OK: $1 has $(wc -l < "$1") lines"
exit 0
```

Make executable:

```bash
chmod +x check-menu.sh
```

## Important commands practised

```bash
echo $?
```

```bash
./check-menu.sh specials.txt
echo $?
```

```bash
./check-menu.sh menu.txt && echo "menu ok" || echo "menu broken"
```

## Key takeaways

1. Exit code `0` means success.
2. `$?` captures the previous command's exit code.
3. `[ ]` is used for conditional testing.
4. `-f` checks whether a regular file exists.
5. `-s` checks whether a file is non-empty.
6. `if`, `elif`, and `else` control execution flow.
7. `exit` stops a script and returns a specified code.
8. `>&2` redirects messages to standard error.
9. `&&` and `||` execute commands based on success or failure.
10. `$( )` captures command output.

**Chapter 25 completed successfully: 5/5 tasks correct.**
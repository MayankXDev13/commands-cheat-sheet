# Your First Script

## What I learned

This chapter covered Bash scripting, command-line arguments, quoting, and creating executable scripts.

### 1. Creating a Bash script

- Used the shebang `#!/bin/bash`.
- Made the script executable using `chmod +x`.
- Executed the script using `./greet.sh`.

### 2. Using command-line arguments

Learned how to access arguments passed to a script:

| Variable | Description |
|---|---|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Total number of arguments |
| `$@` | All arguments |

### 3. Handling names with spaces

Used double quotes to preserve spaces in arguments.

```bash
name="$1"
```

Example:

```bash
./greet.sh "Meera Rao"
./greet.sh "Bunty   the   Intern"
```

### 4. Counting arguments

Used `$#` to count the total arguments passed to the script.

```bash
echo "Names given: $#"
```

## Final greet.sh script

```bash
#!/bin/bash

name="$1"
shop="Tapri"

echo "Namaste, $name! Welcome to $shop."
echo "Names given: $#"
```

## Testing

```bash
./greet.sh Ravi
./greet.sh Ravi Kabir Dev
./greet.sh "Meera Rao"
./greet.sh "Bunty   the   Intern"
```

## Key takeaways

1. The shebang specifies the interpreter.
2. `chmod +x` makes a script executable.
3. `$1` accesses the first argument.
4. `$#` counts the arguments.
5. Double quotes preserve spaces in variable values.
6. Always quote variable expansions when you want to prevent word splitting.

**Chapter 24 completed successfully: 4/4 tasks correct.**
# Loops


## What I learned

This chapter covered Bash loops, glob expansion, filename manipulation, arithmetic operations, and reading files line by line.

### 1. Using `for` loops

A `for` loop executes commands once for every item in a list.

```bash
for d in Mon Tue Wed; do
    echo "Open on $d"
done
```

### 2. Globs and filenames with spaces

Used `*.JPG` to find files ending with uppercase `.JPG`.

```bash
for f in photos/*.JPG; do
    echo mv -- "$f" "${f%.JPG}.jpg"
done
```

- `*.JPG` matches files ending in `.JPG`.
- `"${f%.JPG}"` removes the uppercase extension.
- `"$f"` preserves filenames containing spaces.
- `mv` renames files without changing their contents.

### 3. Counting CSV files

Created `count.sh` to count orders in every CSV file.

```bash
#!/bin/bash

dir="$1"
total=0

for file in "$dir"/*.csv; do
    [ -f "$file" ] || continue

    name="${file##*/}"
    count=$(wc -l < "$file")

    echo "$name: $count orders"

    total=$((total + count))
done

echo "Total: $total orders"
```

Run:

```bash
chmod +x count.sh
./count.sh orders
```

### 4. Understanding filename manipulation

| Syntax | Description |
|---|---|
| `*.csv` | Matches CSV files |
| `${f%.txt}` | Removes `.txt` from the end |
| `${f##*/}` | Removes the folder path |
| `basename "$f"` | Extracts the filename |
| `wc -l < "$f"` | Counts file lines |

### 5. Bash arithmetic

Bash uses `$(( ))` for arithmetic calculations.

```bash
total=0

for n in 3 4; do
    total=$((total + n))
done

echo "$total"
```

Output:

```text
7
```

### 6. Using `while read`

Used `while read` to process a file line by line.

```bash
while IFS=',' read -r name team; do
    echo "$name works in $team"
done < staff.csv
```

Important components:

- `while`: Repeats while the condition succeeds.
- `IFS=','`: Uses comma as the field separator.
- `read -r`: Reads a line without interpreting backslashes.
- `name` and `team`: Store the separated fields.
- `done < staff.csv`: Supplies the file as input.

### 7. Creating prices.sh

Created a script to read item names and prices from a file.

```bash
#!/bin/bash

file="$1"

while IFS=',' read -r item price; do
    echo "$item costs Rs $price"
done < "$file"
```

Run:

```bash
chmod +x prices.sh
./prices.sh prices.txt
```

Example output:

```text
Kesar badam milk costs Rs 60
Masala chai costs Rs 20
Bun maska costs Rs 40
```

## Important commands practised

```bash
for f in photos/*.JPG; do
    mv -- "$f" "${f%.JPG}.jpg"
done
```

```bash
./count.sh orders
```

```bash
./prices.sh prices.txt
```

## Key takeaways

1. `for` loops process multiple files automatically.
2. Globs (`*.csv`, `*.JPG`) match filenames.
3. Double quotes preserve spaces in filenames and variables.
4. `${variable%.extension}` removes a suffix.
5. `${variable##*/}` extracts a filename from a path.
6. `wc -l` counts lines in a file.
7. `$(( ))` performs arithmetic.
8. `while read` processes files line by line.
9. `IFS` controls how input fields are separated.
10. `continue` skips the current loop iteration.

**Chapter 26 completed successfully: 4/4 tasks correct.**
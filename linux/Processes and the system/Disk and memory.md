# Disk and memory

This chapter covers disk usage, finding large files, safely emptying files, cleaning old backups, and checking memory usage. You will use `df`, `du`, `sort`, `find`, `truncate`, and `free`.

## 1. Check disk usage with `df`

`df` means disk free. It displays filesystem disk space usage.

```bash
df -h .
```

Explanation:

- `df` — displays filesystem disk usage.
- `-h` — human-readable sizes (KB, MB, GB).
- `.` — checks the filesystem containing the current directory.

Example output:

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/vdb        1.9G  214M  1.6G  12% /
```

Important columns:

| Column | Meaning |
|---|---|
| Filesystem | Disk or filesystem name |
| Size | Total capacity |
| Used | Space already occupied |
| Avail | Available space |
| Use% | Percentage of used space |
| Mounted on | Mount location |

To check all mounted filesystems:

```bash
df -h
```

## 2. Check folder and file sizes with `du`

`du` means disk usage. It calculates how much space files and directories consume.

```bash
du -h .
```

- `du` — calculates disk usage.
- `-h` — human-readable sizes.
- `.` — current directory.

### A. Show one total per folder

```bash
du -sh *
```

Explanation:

- `-s` — summary; show one total per specified name.
- `-h` — human-readable sizes.
- `*` — all visible entries in the current directory.

Example:

```text
12K     ./app
41M     ./backups
61M     ./logs
```

This helps identify which folder is consuming the most space.

### B. Show all files and folders

```bash
du -ah .
```

Explanation:

- `-a` — include individual files as well as directories.
- `-h` — display human-readable sizes.
- `.` — start from the current directory.

Example:

```text
4.0K    ./app/README.md
4.0K    ./app/package.json
4.0K    ./logs/error.log
8.1M    ./backups/tapri-2026-09-27.tar.gz
60M     ./logs/orders.log
61M     ./logs
101M    .
```

Directories also appear because `du` calculates their total sizes.

### C. Sort sizes with `sort -h`

```bash
du -ah . | sort -h
```

Explanation:

- `|` — pipe; sends the output of one command to another.
- `sort` — sorts lines.
- `-h` — understands human-readable size units such as K, M, and G.

Smallest files appear first, biggest entries last.

To show the biggest entries first:

```bash
du -ah . | sort -hr
```

To show only the four biggest entries:

```bash
du -ah . | sort -h | tail -n 4
```

Remember: directory totals also appear. Ignore directories when identifying the biggest individual file.

## 3. Find the biggest individual file

Use `find` to locate files without including directory totals.

```bash
find . -type f
```

Explanation:

- `find` — searches for files and directories.
- `.` — search from the current directory.
- `-type f` — regular files only.

Find files larger than 10 MB:

```bash
find . -type f -size +10M
```

Sort files by their human-readable disk usage:

```bash
find . -type f -exec du -h {} + | sort -h
```

Biggest file first:

```bash
find . -type f -exec du -h {} + | sort -hr
```

### Save the biggest file path

```bash
du -ah . | sort -h
```

Identify the biggest regular file, ignoring directory entries, and save its path:

```bash
find . -type f ! -name biggest.txt -printf '%s\t%p\n' | sort -n | tail -n 1 | cut -f2- > biggest.txt
```

Explanation:

- `! -name biggest.txt` — exclude the output file.
- `-printf '%s\t%p\n'` — print file size in bytes and path.
- `sort -n` — sort numerically.
- `tail -n 1` — select the largest entry.
- `cut -f2-` — extract the path.
- `> biggest.txt` — save the path.

Verify:

```bash
cat biggest.txt
```

## 4. Empty a file without deleting it

Sometimes an application is actively writing to a log file.

Deleting the file using `rm` does not necessarily free its disk space if a running process still holds it open.

### A. Understand the problem

```bash
sleep 1000 >> kettle.log &
```

This starts a background process that keeps the file open.

```bash
rm kettle.log
```

The filename is deleted, but the process still holds the original file open.

Check:

```bash
ls -l /proc/$!/fd/1
```

The output may show:

```text
kettle.log (deleted)
```

### B. Empty the file using `truncate`

`truncate` changes the size of a file without deleting it.

Syntax:

```bash
truncate -s SIZE FILE
```

Explanation:

- `truncate` — changes file size.
- `-s` — specifies the target size (`--size`).
- `0` — sets the file size to zero bytes.

Empty a file:

```bash
truncate -s 0 logs/orders.log
```

Set the file size to 100 bytes:

```bash
truncate -s 100 logs/orders.log
```

Set the file size to 1 MB:

```bash
truncate -s 1M logs/orders.log
```

### C. Understand file inode

An inode is a filesystem data structure that identifies a file and stores its metadata.

Check inode and size before truncating:

```bash
stat -c '%i %s %n' logs/orders.log
```

Empty the file:

```bash
truncate -s 0 logs/orders.log
```

Check again:

```bash
stat -c '%i %s %n' logs/orders.log
```

Example:

```text
34605049 62914560 logs/orders.log
34605049 0 logs/orders.log
```

Notice:

- Inode remains the same.
- File size changes from 60 MB to zero.
- The file still exists.
- The application can continue writing to the same file.

### D. Alternative ways to empty a file

Using shell redirection:

```bash
> logs/orders.log
```

Using `/dev/null`:

```bash
cat /dev/null > logs/orders.log
```

Important device files:

| Device | Purpose |
|---|---|
| `/dev/null` | Discards everything written to it |
| `/dev/zero` | Produces an unlimited stream of zero bytes |
| `/dev/random` | Provides random data |
| `/dev/urandom` | Provides pseudorandom data |

Do not use `cat /dev/zero > logfile`: it continuously writes zeros and can fill your disk.

## 5. Manage old backups

Use `ls -lt` to list files by modification time, newest first.

```bash
ls -lt backups/
```

Explanation:

- `ls` — lists files.
- `-l` — long listing format.
- `-t` — sorts by modification time, newest first.

To show oldest files first:

```bash
ls -ltr backups/
```

Be careful when deleting old backups. Check the list before using `rm`.

```bash
ls -lt backups/
```

The chapter task requires keeping only the two newest backups.

## 6. Check memory usage with `free`

`free` displays RAM and swap usage.

```bash
free -h
```

Explanation:

- `free` — displays memory usage.
- `-h` — human-readable units (MB, GB).

Example:

```text
               total        used        free      shared  buff/cache   available
Mem:           7.7Gi       1.8Gi       504Mi        54Mi       5.7Gi       5.9Gi
Swap:          1.0Gi        45Mi       978Mi
```

Important columns:

| Column | Meaning |
|---|---|
| total | Total memory |
| used | Memory currently used |
| free | Completely unused memory |
| shared | Shared memory |
| buff/cache | Memory used for buffers and cache |
| available | Estimated memory available for applications |

**Important:** Linux uses spare RAM for caching. Therefore, low `free` memory is not necessarily a problem. Pay attention to `available`.

## 7. Save disk and memory reports

You can save command output into a file.

### A. Save disk report

```bash
df -h > health.txt
```

`>` creates the file or overwrites its existing contents.

### B. Append memory report

```bash
free -h >> health.txt
```

`>>` appends output to the end of the existing file.

### C. Verify

```bash
cat health.txt
```

The file should contain:

1. Disk filesystem report from `df -h`.
2. Memory report from `free -h`, including the `Mem:` line.

### Difference between `>` and `>>`

| Operator | Meaning |
|---|---|
| `>` | Overwrite file |
| `>>` | Append to file |

## 8. Complete the chapter tasks

Run the commands from the Chapter 21 folder.

### Task 1: Find the biggest file

```bash
du -sh *
du -ah . | sort -h
```

Ignore directory totals and identify the largest individual file.

Write its relative path into `biggest.txt`.

### Task 2: Empty the orders log

```bash
stat logs/orders.log
truncate -s 0 logs/orders.log
stat logs/orders.log
```

The inode must remain unchanged, and the file size must be at most 100 bytes.

### Task 3: Keep only two newest backups

```bash
ls -lt backups/
```

Inspect the list and carefully remove all backups except the two newest ones.

### Task 4: Create the health report

```bash
df -h > health.txt
free -h >> health.txt
```

Verify:

```bash
cat health.txt
```

## Quick command reference

```bash
df -h                  # Check disk usage
du -h .                # Check directory disk usage
du -sh *               # One total per name
du -ah .               # Show files and directories
du -ah . | sort -h     # Smallest to largest
du -ah . | sort -hr    # Largest to smallest
find . -type f         # Find regular files
find . -type f -size +10M  # Find files larger than 10 MB
truncate -s 0 file     # Empty a file in place
stat file              # Check file metadata
ls -lt backups/        # Newest files first
ls -ltr backups/       # Oldest files first
free -h                # Check RAM and swap
df -h > health.txt     # Save disk report
free -h >> health.txt  # Append memory report
```

**Remember:**

- `df` tells you how full the filesystem is.
- `du` tells you which files and directories consume space.
- `find` helps locate individual files.
- `sort -h` sorts human-readable sizes.
- `truncate` empties a file without deleting it.
- `free` reports memory usage.

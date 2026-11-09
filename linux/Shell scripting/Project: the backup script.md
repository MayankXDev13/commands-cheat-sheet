# Project: the backup script

## What I learned

This chapter covered Bash backup automation, date-based archive names,
creating clean compressed archives with `tar`, retaining the newest
backups, logging script activity, and scheduling jobs with cron.

### 1. Generating date-based filenames

Used `date` with format specifiers to generate timestamps for backup
filenames.

``` bash
date +%F-%H%M%S
echo "notes-$(date +%F).txt"
```

Important components:

-   `%F`: Formats the date as `YYYY-MM-DD`.
-   `%H%M%S`: Formats the time as hours, minutes, and seconds.
-   `$(...)`: Runs a command and substitutes its output.
-   Date-first filenames sort chronologically when listed
    alphabetically.

When using `printf`, write `%%` to display a literal percent sign in the
format string. Percent signs inside a `%s` argument are not treated as
format specifiers.

### 2. Creating compressed archives with `tar`

Used `tar -czf` to create a compressed `.tar.gz` archive.

``` bash
tar -czf out/full.tar.gz /tmp/bakdemo/shop
```

Useful `tar` options:

  -----------------------------------------------------------------------
  Option                              Description
  ----------------------------------- -----------------------------------
  `-c`                                Creates a new archive.

  `-z`                                Compresses the archive using gzip.

  `-f`                                Specifies the archive filename.

  `-t`                                Lists the contents of an archive.

  `-C`                                Changes to a directory before
                                      adding files.

  `--exclude=cache`                   Excludes files or directories
                                      matching the specified pattern.
  -----------------------------------------------------------------------

To archive a folder without storing its full absolute path, use
`dirname` and `basename` with `-C`.

``` bash
src=/tmp/bakdemo/shop

tar -czf out/short.tar.gz \
    --exclude=cache \
    -C "$(dirname "$src")" \
    "$(basename "$src")"
```

-   `dirname "$src"`: Extracts the parent directory.
-   `basename "$src"`: Extracts the final folder name.
-   `-C`: Makes `tar` enter the parent directory before adding the
    folder.
-   `--exclude=cache`: Leaves the cache directory out of the archive.

Used `tar -tzf` to inspect an archive without extracting it.

``` bash
tar -tzf out/short.tar.gz
```

### 3. Keeping only the newest backups

Used `ls -1t` to list backup archives one per line, ordered by
modification time, newest first.

``` bash
ls -1t out/shop-*.tar.gz
```

Used `tail -n +3` to skip the first two entries and display older
backups.

``` bash
ls -1t out/shop-*.tar.gz | tail -n +3
```

To delete everything except the newest two backups:

``` bash
ls -1t out/shop-*.tar.gz | tail -n +3 | xargs -r rm --
```

Important components:

-   `ls -1t`: Lists one file per line, newest first.
-   `tail -n +3`: Outputs from the third line onward.
-   `xargs`: Converts input lines into command arguments.
-   `-r`: Prevents `xargs` from running the command when the input is
    empty.
-   `rm --`: Removes the specified files and treats following arguments
    as filenames, not options.

This pipeline is suitable for the date-based backup names used in this
chapter, which do not contain spaces.

### 4. Logging backup activity

Used `>>` to append a timestamped message to a log file without
overwriting earlier entries.

``` bash
echo "$(date '+%F %T') packed shop into out" >> out/pack.log
```

-   `date '+%F %T'`: Generates a timestamp containing the date and time.
-   `>>`: Appends output to a file.
-   `out/pack.log`: Stores the backup activity history.

### 5. Using strict mode in backup scripts

Used strict mode to stop the script when a command fails.

``` bash
#!/bin/bash
set -euo pipefail
```

This is important in a backup script because a failed archive operation
should stop the script before old backups are deleted.

  -----------------------------------------------------------------------
  Option                              Description
  ----------------------------------- -----------------------------------
  `-e`                                Stops on command failures, subject
                                      to Bash's conditional-command
                                      exceptions.

  `-u`                                Treats unset variables as errors.

  `-o pipefail`                       Makes a pipeline fail if any
                                      command in it fails.
  -----------------------------------------------------------------------

### 6. Scheduling backups with cron

Cron runs commands automatically at scheduled times.

Example cron format:

``` text
45 18 * * 6 /absolute/path/report.sh
```

Cron fields:

  Field   Meaning
  ------- ------------------------
  `45`    Minute
  `18`    Hour
  `*`     Every day of the month
  `*`     Every month
  `6`     Saturday

This example runs the script every Saturday at 18:45.

Cron jobs should use absolute paths because cron starts jobs with a
limited environment and a short `PATH`.

Used `$PWD` inside double quotes to insert the current directory into a
cron command:

``` bash
echo "45 18 * * 6 $PWD/report.sh"
```

Single quotes preserve `$PWD` as literal text:

``` bash
echo '45 18 * * 6 $PWD/report.sh'
```

Use `crontab -l` to inspect existing cron entries. When adding a new
entry, preserve the existing entries by combining the current crontab
with the new line.

## Important commands practised

``` bash
date +%F-%H%M%S
```

``` bash
tar -czf out/backup.tar.gz --exclude=cache -C /path/to/parent folder
```

``` bash
tar -tzf out/backup.tar.gz
```

``` bash
ls -1t out/shop-*.tar.gz | tail -n +3
```

``` bash
ls -1t out/shop-*.tar.gz | tail -n +3 | xargs -r rm --
```

``` bash
echo "$(date '+%F %T') backup completed" >> out/pack.log
```

``` bash
crontab -l
```

## Key takeaways

1.  `date +%F-%H%M%S` generates date-and-time strings for backup
    filenames.
2.  Date-first filenames make backups easier to sort chronologically.
3.  `tar -czf` creates gzip-compressed archives.
4.  `tar -tzf` lists archive contents without extracting them.
5.  `-C` controls the directory from which `tar` stores files.
6.  `dirname` extracts a parent directory, while `basename` extracts the
    final path component.
7.  `--exclude` prevents selected files or directories from entering an
    archive.
8.  `ls -1t` lists files newest first.
9.  `tail -n +3` skips the newest two entries.
10. `xargs -r rm --` removes older backup files and does nothing when
    the list is empty.
11. `>>` appends timestamped messages to a log file.
12. Strict mode helps prevent cleanup from running after a failed backup
    command.
13. Cron schedules scripts to run automatically at specified times.
14. Cron jobs should use absolute paths and preserve existing crontab
    entries.

**Chapter 28: Project --- the backup script --- key concepts covered.**
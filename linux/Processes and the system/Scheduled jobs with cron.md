# Scheduled Jobs with Cron

## Task results

**Status: 4 / 4 correct**

### 1. Arjun's cache clean-up at 2:00 AM

Cron fields are:

1.  Minute
2.  Hour
3.  Day of month
4.  Month
5.  Day of week

The correct schedule is `0 2 * * *`.

``` cron
0 2 * * * /workspace/chapters/22-cron/bin/clean-cache.sh
```

The original `* 2 * * *` ran every minute during the 2 AM hour. Changing
the minute field to `0` makes it run once, at 2:00 AM.

### 2. Order report every 5 minutes

Use `*/5` in the minute field and the full script path:

``` cron
*/5 * * * * /workspace/chapters/22-cron/bin/order-report.sh
```

This runs at minutes 0, 5, 10, 15, and so on, every hour.

### 3. Append report output and errors to the log

Use `>>` to append standard output to the log, then `2>&1` to send
standard error to the same destination:

``` cron
*/5 * * * * /workspace/chapters/22-cron/bin/order-report.sh >> /workspace/chapters/22-cron/logs/report.log 2>&1
```

-   `>>` appends output and preserves older log entries.
-   `2>&1` redirects file descriptor 2 (standard error) to wherever file
    descriptor 1 (standard output) is currently going.
-   The order matters: put `2>&1` after the `>>` redirection.

### 4. Every Monday at 9:30 AM

Write these five cron fields to `schedule.txt`:

``` cron
30 9 * * 1
```

Field meanings:

  Field            Value Meaning
  -------------- ------- ------------------------
  Minute            `30` At minute 30
  Hour               `9` At 9 AM
  Day of month       `*` Every day of the month
  Month              `*` Every month
  Day of week        `1` Monday (Sunday is 0)

Create and verify the file:

``` bash
cd /workspace/chapters/22-cron
echo "30 9 * * 1" > schedule.txt
cat schedule.txt
```

## Final crontab

The crontab should retain Arjun's comment and contain exactly one
clean-up job and one order-report job:

``` cron
# Arjun: nightly cache clean-up for /workspace/chapters/22-cron, meant for 2 am
0 2 * * * /workspace/chapters/22-cron/bin/clean-cache.sh

# The order report every 5 minutes and append the logs this report.log
*/5 * * * * /workspace/chapters/22-cron/bin/order-report.sh >> /workspace/chapters/22-cron/logs/report.log 2>&1
```

Inspect it with:

``` bash
crontab -l
```

## Editing the crontab safely

Open the current crontab in an editor:

``` bash
crontab -e
```

Save the file after making changes, then verify with `crontab -l`.

You can also transform the existing crontab through a pipe. For example,
this changes the first field of Arjun's `2 AM` line from `*` to `0`
while retaining the other entries:

``` bash
crontab -l | sed 's/^\* 2 /0 2 /' | crontab -
```

**Caution:** `echo 'one cron line' | crontab -` replaces the entire
crontab with that single line. Preserve existing entries when rebuilding
a crontab.

## Important cron behavior

-   A user's crontab has five time fields followed by the command; it
    does not have a username field.
-   `*` means every valid value in that field.
-   `*/N` means every N units in that field.
-   Cron commonly starts commands in the user's home directory, not the
    script's directory. Use absolute paths for scripts and log files.
-   Cron jobs run without an interactive terminal. Redirect output and
    errors to a log when needed.
-   Cron's environment is limited; do not assume your interactive
    shell's `PATH` or environment variables are available.
-   This chapter's lab container may not run a cron daemon. The exercise
    checks the crontab contents rather than waiting for scheduled jobs
    to execute.

## Quick reference

  Schedule        Meaning
  --------------- ----------------------------
  `* * * * *`     Every minute
  `0 2 * * *`     Every day at 2:00 AM
  `*/5 * * * *`   Every 5 minutes
  `15 * * * *`    At minute 15 of every hour
  `30 9 * * 1`    Every Monday at 9:30 AM
  `45 18 * * 6`   Every Saturday at 6:45 PM
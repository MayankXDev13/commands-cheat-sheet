# jobs and the background

This chapter covers background jobs, job control, and `nohup`. You will run a command without blocking the terminal, inspect jobs, and start a process that ignores the hangup signal.

## 1. Run a command in the background

Add `&` to the end of a command:

```bash
./bin/tapri-menu-sync.sh &
```

The shell starts the command in the background and returns the prompt.

List jobs started by the current shell:

```bash
jobs
```

The output shows a job number and its state. A job can be `Running`, `Stopped`, or `Done`.

Wait for a background job to finish:

```bash
wait
```

You can then check the file or output that the command creates.

## 2. Move jobs between foreground and background

Press `Ctrl+Z` to suspend a foreground job. This pauses the process.

Resume the most recently suspended job in the background:

```bash
bg
```

Bring a background job to the foreground:

```bash
fg
```

If you have several jobs, specify the job number. For example:

```bash
fg %1
```

Stop job 1 with the default termination signal:

```bash
kill %1
```

Here `%1` means job number 1 in the current shell. It is not a process ID.

## 3. What happens when a terminal closes?

When a terminal session ends, the shell may send `SIGHUP` to its jobs. A process that receives the default action for `SIGHUP` usually exits.

`SIGHUP` means hangup. Its signal number is 1.

You can list signal names and numbers with:

```bash
kill -l
```

## 4. Use `nohup` to ignore SIGHUP

`nohup` starts a command with `SIGHUP` ignored. This lets the command continue when the terminal closes, provided nothing else stops it.

Basic example:

```bash
nohup ./bin/tapri-printer.sh &
```

By default, `nohup` sends output to `nohup.out` if the output is connected to a terminal. You can choose a log file instead.

## 5. Redirect output to a log

Linux uses file descriptor 1 for standard output and file descriptor 2 for standard error.

Use `> file` to send standard output to a file. Use `2>&1` to send standard error to the same destination:

```bash
nohup ./bin/tapri-printer.sh > logs/printer.log 2>&1 < /dev/null &
```

- `nohup` makes the command ignore `SIGHUP`.
- `>` redirects standard output to `logs/printer.log`.
- `2>&1` redirects standard error to the same file as standard output.
- `< /dev/null` gives the command no terminal input.
- `&` starts the command in the background.

Create the log directory first if it does not exist:

```bash
mkdir -p logs
```

Check the process:

```bash
pgrep -af '[t]apri-printer.sh'
```

Check where its output goes. Replace `<PID>` with the process ID:

```bash
readlink /proc/<PID>/fd/1
readlink /proc/<PID>/fd/2
```

Both commands should show the path to `logs/printer.log`.

## 6. Example: run a background command and wait for it

Create a small script:

```bash
cat > brew.sh <<'EOF'
#!/bin/bash
echo "Brewing..."
sleep 3
echo "Tea is ready"
EOF

chmod +x brew.sh
```

Start it in the background and save its PID:

```bash
./brew.sh &
job_pid=$!
```

Check the job:

```bash
jobs
```

Wait for this command to finish:

```bash
wait "$job_pid"
```

The shell returns to the prompt after the script exits.

## 7. Complete the chapter tasks

Run these commands from the Chapter 20 folder.

### Task 1: run menu sync in the background

```bash
./bin/tapri-menu-sync.sh &
sync_pid=$!
jobs
wait "$sync_pid"
cat menu-synced.txt
```

### Task 2 and 3: keep exactly one printer running and write its output to the log

First stop existing copies so that you can start one copy with the required output redirection:

```bash
pkill -TERM -f '[t]apri-printer.sh'
sleep 1
pgrep -af '[t]apri-printer.sh'
```

If a printer process remains, check the PID before forcing it to stop:

```bash
pgrep -af '[t]apri-printer.sh'
kill -KILL <PID>
```

Start one printer:

```bash
mkdir -p logs
nohup ./bin/tapri-printer.sh > logs/printer.log 2>&1 < /dev/null &
```

Verify that exactly one printer is running:

```bash
pgrep -af '[t]apri-printer.sh'
```

Check its output file by replacing `<PID>` with the PID shown above:

```bash
readlink /proc/<PID>/fd/1
readlink /proc/<PID>/fd/2
```

Both should point to the chapter's `logs/printer.log`.

### Task 4: write the signal name

`nohup` makes a command ignore `SIGHUP`. Write that signal name to `answer.txt`:

```bash
printf 'SIGHUP\n' > answer.txt
cat answer.txt
```

## Quick command reference

```bash
command &              # Start a command in the background
jobs                   # List jobs in the current shell
wait                   # Wait for background jobs to finish
Ctrl+Z                 # Suspend the foreground job
bg                     # Resume a suspended job in the background
fg %1                  # Bring job 1 to the foreground
kill %1                # Send the default termination signal to job 1
kill -l                # List signal names and numbers
nohup command &        # Run a command while ignoring SIGHUP
```
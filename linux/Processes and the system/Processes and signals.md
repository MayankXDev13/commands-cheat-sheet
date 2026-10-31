# Processes and signals

This chapter covers Linux processes, process IDs, and signals. You will use `ps` and `pgrep` to find processes, then use `kill` to stop them.

## 1. Processes, PID, and PPID

A process is a running program. Linux assigns each process a Process ID, or PID.

- PID is the ID of a process.
- PPID is the ID of the parent process that started it.
- `ps` lists process information.

Show processes in a tree:

```bash
ps -ef --forest
```

The `--forest` option shows parent and child processes as a tree. Use it to see which process started another process.

## 2. Find a process with `pgrep`

Use `pgrep` to search for a process.

```bash
pgrep -af 'polite|stubborn'
```

- `-f` searches the full command line.
- `-a` prints the PID and the command line.

Use a specific search pattern. A broad pattern may match processes you did not intend to stop.

## 3. Signals

A signal is a message that the operating system sends to a process. A signal can ask a process to stop, pause, or handle an event.

Read the signal manual:

```bash
man 7 signal
```

`man` opens a manual page. The number `7` selects section 7, which contains miscellaneous system information. The page named `signal` explains Linux signals.

Read the manual for the `kill` command:

```bash
man kill
```

List signal names and numbers:

```bash
kill -l
```

### Common signals

| Signal | Number | What it does |
|---|---:|---|
| `SIGHUP` | 1 | Reports a hangup, often when a terminal connection ends. |
| `SIGINT` | 2 | Interrupts a process. The terminal usually sends it when you press Ctrl+C. |
| `SIGQUIT` | 3 | Requests that a process quit. The default action may create a core dump. |
| `SIGKILL` | 9 | Stops a process immediately. The process cannot catch or ignore it. |
| `SIGTERM` | 15 | Asks a process to stop. The process can handle or ignore it. |
| `SIGSTOP` | 19 on x86 and ARM | Pauses a process. The process cannot catch or ignore it. |

Signal numbers can differ between processor architectures. Use signal names when writing commands that should work on different systems.

## 4. Example: start and stop a process

Create a Bash script that writes a message when it receives `SIGTERM`:

```bash
cat > polite.sh <<'EOF'
#!/bin/bash
trap 'echo "Received SIGTERM; shutting down" >> demo.log; exit 0' TERM

while true; do
    sleep 1
done
EOF

chmod +x polite.sh
```

Start the script in the background:

```bash
./polite.sh &
```

Find its PID:

```bash
pgrep -af './polite.sh'
```

The output includes the PID and command line. Use the PID from your terminal in the next command:

```bash
kill -TERM <PID>
```

You can also write the signal name with `-s`:

```bash
kill -s SIGTERM <PID>
```

Read the log:

```bash
cat demo.log
```

Expected output:

```text
Received SIGTERM; shutting down
```

The `trap` command tells Bash what to do when the script receives `SIGTERM`. The script writes a message and exits.

## 5. Stop a process with `SIGKILL`

Try `SIGTERM` first. A process may ignore it or fail to exit.

If the process is still running, check its PID and then send `SIGKILL`:

```bash
kill -KILL <PID>
```

You can also use the signal number:

```bash
kill -9 <PID>
```

The kernel stops the process. The process cannot run its cleanup code or save unsaved work.

Use this order:

1. Send `SIGTERM`.
2. Wait briefly.
3. Check whether the process is still running.
4. Send `SIGKILL` only if it has not stopped and you have checked the PID.

## Quick command reference

```bash
ps -ef --forest          # List processes as a tree
pgrep -af 'name'         # Find processes and show their command lines
man 7 signal             # Read the Linux signal manual
man kill                 # Read the kill command manual
kill -l                  # List signal names and numbers
kill -TERM <PID>         # Ask a process to stop
kill -KILL <PID>         # Force a process to stop
```
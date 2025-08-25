# 🐧 30-Day Linux Mastery Plan

## 📅 Week 1 – Basics & Navigation (Foundation)
**Day 1**: Install Linux (Ubuntu/Debian recommended) in VM/WSL/Docker.  
- Task: Explore filesystem with `ls`, `pwd`, `cd`.  
- Mini Project: Create a folder structure like `/projects/myapp/{src,logs,bin}`.

**Day 2**: File operations.  
- Commands: `cp`, `mv`, `rm`, `touch`, `find`, `locate`.  
- Task: Move files around, rename them.  
- Mini Project: Write a script that finds all `.log` files in `/var/log` and copies them to `/home/backup`.

**Day 3**: Viewing & editing files.  
- Commands: `cat`, `less`, `head`, `tail`, `nano`, `vim`.  
- Task: Use `tail -f /var/log/syslog`.  
- Mini Project: Edit a file with Vim (practice modes).

**Day 4**: Users & groups.  
- Commands: `whoami`, `id`, `adduser`, `passwd`, `groups`.  
- Task: Create a new user `devuser` with sudo access.  
- Mini Project: Create 2 users and a group, then add both users to the group.

**Day 5**: File permissions.  
- Commands: `ls -l`, `chmod`, `chown`, `chgrp`.  
- Task: Experiment with symbolic (`u+x`) and numeric (`755`) permissions.  
- Mini Project: Write a script to set permissions so only the owner can read/write.

**Day 6**: Processes.  
- Commands: `ps`, `top`, `htop`, `kill`, `jobs`, `bg`, `fg`.  
- Task: Run a script in the background.  
- Mini Project: Write a script that launches 3 background processes and kills them after 10 seconds.

**Day 7**: Review & challenge.  
- Challenge: Create a “Linux diary” documenting all commands so far.  
- Mini Project: Build a **basic system info script** (show date, uptime, hostname, CPU load).

---

## 📅 Week 2 – Package Management, Services & Networking
**Day 8**: Package management.  
- Commands: `apt`, `dpkg` (Debian), `yum/dnf` (RHEL).  
- Task: Install and remove packages (e.g., `htop`, `curl`).  
- Mini Project: Install Apache/Nginx and verify it’s running.

**Day 9**: Systemd & services.  
- Commands: `systemctl start/stop/status/enable`, `journalctl`.  
- Task: Enable Apache/Nginx to start at boot.  
- Mini Project: Write a script to restart a service if it stops.

**Day 10**: Disk & storage.  
- Commands: `df`, `du`, `lsblk`, `mount`, `umount`.  
- Task: Check disk usage and mount a new volume (VM/USB).  
- Mini Project: Script that checks free disk space and sends a warning if <20%.

**Day 11**: Networking basics.  
- Commands: `ping`, `curl`, `wget`, `netstat`, `ss`, `traceroute`.  
- Task: Test connectivity to google.com.  
- Mini Project: Script that checks if a website is up and logs the result.

**Day 12**: SSH & file transfers.  
- Commands: `ssh`, `scp`, `rsync`.  
- Task: Setup key-based authentication between two Linux machines/VMs.  
- Mini Project: Use `scp`/`rsync` to automate daily backup of `/home/devuser`.

**Day 13**: Archiving & compression.  
- Commands: `tar`, `gzip`, `zip`, `unzip`.  
- Task: Archive your `/projects` folder.  
- Mini Project: Script that compresses log files older than 7 days.

**Day 14**: Review & challenge.  
- Challenge: Deploy a simple static website on Nginx/Apache.  
- Mini Project: Automate its start/stop with a script.

---

## 📅 Week 3 – Shell Scripting & Automation
**Day 15**: Shell basics.  
- Learn: variables, conditionals (`if`).  
- Task: Write a script that checks if a file exists.  

**Day 16**: Loops & functions.  
- Write scripts with `for`, `while`, `until`.  
- Mini Project: Script that prints numbers 1–20 using a loop.

**Day 17**: Cron jobs.  
- Commands: `crontab -e`, scheduling tasks.  
- Task: Schedule a script that prints date every 5 mins.  
- Mini Project: Automate daily log backup with cron.

**Day 18**: Text processing.  
- Commands: `grep`, `cut`, `sort`, `uniq`.  
- Mini Project: Script that finds top 5 IPs from `/var/log/auth.log`.

**Day 19**: Sed & awk.  
- Task: Replace words with `sed`, extract columns with `awk`.  
- Mini Project: Build a **log analyzer** script that detects failed SSH logins.

**Day 20**: Piping & redirection.  
- Operators: `|`, `>`, `>>`, `2>`, `&>`.  
- Task: Save command output to files.  
- Mini Project: Script that redirects errors & logs separately.

**Day 21**: Review & challenge.  
- Challenge: Combine `awk`, `grep`, `sed` to parse logs.  
- Mini Project: Create a **mini system monitoring script** (CPU, memory, disk, uptime).

---

## 📅 Week 4 – Advanced & DevOps-Oriented Linux
**Day 22**: Security basics.  
- Commands: `ufw`, `iptables`, `firewalld`.  
- Task: Allow only SSH (22) & HTTP (80) traffic.  
- Mini Project: Configure key-based SSH & disable password login.

**Day 23**: Performance monitoring.  
- Commands: `vmstat`, `iostat`, `sar`, `iotop`.  
- Task: Monitor system load during stress test.  
- Mini Project: Script that logs CPU & memory every 5 mins.

**Day 24**: Logs & troubleshooting.  
- Commands: `dmesg`, `journalctl`, `strace`.  
- Task: Debug a failed service.  
- Mini Project: Write a script that checks last 20 error logs and emails them.

**Day 25**: Kernel & `/proc`.  
- Explore `/proc/cpuinfo`, `/proc/meminfo`.  
- Task: Read process info from `/proc/[pid]/status`.  
- Mini Project: Script that lists top 5 memory-consuming processes.

**Day 26**: Linux + Docker basics.  
- Task: Install Docker, run a container (`nginx`).  
- Mini Project: Write a script that checks if Docker is running, if not → restart it.

**Day 27**: Linux in CI/CD.  
- Task: Use Linux commands in GitHub Actions or a simple bash script.  
- Mini Project: Script that auto-deploys a static site when files change.

**Day 28**: Advanced scripting.  
- Task: Write a menu-driven script (start service, stop service, check status).  
- Mini Project: Build a **Linux Admin Toolkit** script.

**Day 29**: Final Project.  
- Automate a **backup & monitoring system**:  
  - Backup `/home` daily.  
  - Compress old logs.  
  - Monitor CPU/memory.  
  - Email report.

**Day 30**: Review & polish.  
- Write a summary of everything you learned.  
- Create a **Linux cheatsheet** (commands + your scripts).  
- Push all your scripts to GitHub as your **Linux DevOps toolkit**.

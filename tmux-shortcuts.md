# TMUX Shortcuts Cheat Sheet

## Prefix Key

* **Prefix:** `Ctrl + a`
* Press the prefix first, then the command key.

Example: `Ctrl+a` → then press the command key.

---

# Pane Shortcuts

## Split Panes

| Shortcut     | Action                |                         |
| ------------ | --------------------- | ----------------------- |
| `Ctrl+a` `   | `                     | Split pane horizontally |
| `Ctrl+a` `-` | Split pane vertically |                         |

---

## Move Between Panes

| Shortcut     | Action              |
| ------------ | ------------------- |
| `Ctrl+a` `h` | Move to left pane   |
| `Ctrl+a` `j` | Move to bottom pane |
| `Ctrl+a` `k` | Move to top pane    |
| `Ctrl+a` `l` | Move to right pane  |

---

## Resize Panes

| Shortcut     | Action            |
| ------------ | ----------------- |
| `Ctrl+a` `H` | Resize pane left  |
| `Ctrl+a` `J` | Resize pane down  |
| `Ctrl+a` `K` | Resize pane up    |
| `Ctrl+a` `L` | Resize pane right |

Each resize moves the pane by **5 cells**.

---

# Window Shortcuts

## Window Management

| Shortcut     | Action                |
| ------------ | --------------------- |
| `Ctrl+a` `c` | Create new window     |
| `Ctrl+a` `,` | Rename current window |
| `Ctrl+a` `&` | Kill current window   |
| `Ctrl+a` `w` | List windows          |

---

## Switch Windows

| Shortcut       | Action              |
| -------------- | ------------------- |
| `Ctrl+a` `n`   | Next window         |
| `Ctrl+a` `p`   | Previous window     |
| `Ctrl+a` `1-9` | Go to window number |

---

# Session Commands

| Command                     | Action             |
| --------------------------- | ------------------ |
| `tmux new -s name`          | Create new session |
| `tmux ls`                   | List sessions      |
| `tmux attach -t name`       | Attach to session  |
| `tmux kill-session -t name` | Kill session       |

---

# Configuration

| Shortcut     | Action              |
| ------------ | ------------------- |
| `Ctrl+a` `r` | Reload `.tmux.conf` |

Displays message: **Config Reloaded**

---

# Plugin Shortcuts

| Shortcut         | Action          |
| ---------------- | --------------- |
| `Ctrl+a` `I`     | Install plugins |
| `Ctrl+a` `U`     | Update plugins  |
| `Ctrl+a` `Alt+u` | Remove plugins  |

Plugins are managed using **TPM (Tmux Plugin Manager)**.

---

# Status Bar Information

Your tmux status bar displays:

| Segment | Description                   |
| ------- | ----------------------------- |
| Session | Current tmux session          |
| CPU     | CPU usage                     |
| RAM     | Memory usage                  |
| IO      | Disk input/output             |
| NET     | Network download/upload speed |
| GIT     | Current git branch            |
| TIME    | Current time and date         |

### Time Format

The status bar shows time using:

```
HH:MM AM/PM DD-MM-YYYY
```

Example:

```
07:42 PM 15-03-2026
```

---

# General Settings

### Mouse Support

Mouse is enabled for:

* Selecting panes
* Resizing panes
* Switching windows

### History

Scrollback history limit: **20,000 lines**

### Indexing

* Windows start at **1**
* Panes start at **1**

---

# Session Persistence

Using **tmux-resurrect** and **tmux-continuum**:

* Sessions auto-save every **15 minutes**
* Sessions restore automatically after restart

---

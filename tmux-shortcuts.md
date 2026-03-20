# TMUX Shortcuts Cheat Sheet (Updated)

## Prefix Key

-   Prefix: Ctrl + b\
-   Press prefix first, then command key

Example: Ctrl+b → then press command key

------------------------------------------------------------------------

# Pane Shortcuts

## Split Panes (Default)

-   Ctrl+b " → Split horizontally\
-   Ctrl+b % → Split vertically

------------------------------------------------------------------------

## Move Between Panes

-   Ctrl+b + Arrow Keys

------------------------------------------------------------------------

## Resize Panes

1.  Press Ctrl+b\
2.  Hold Alt\
3.  Use Arrow Keys

------------------------------------------------------------------------

# Window Shortcuts

## Window Management

-   Ctrl+b c → New window\
-   Ctrl+b , → Rename window\
-   Ctrl+b & → Kill window\
-   Ctrl+b w → List windows

------------------------------------------------------------------------

## Switch Windows

-   Ctrl+b n → Next\
-   Ctrl+b p → Previous\
-   Ctrl+b 0-9 → Go to window

------------------------------------------------------------------------

# Session Commands

-   tmux new -s name\
-   tmux ls\
-   tmux attach -t name\
-   tmux kill-session -t name

------------------------------------------------------------------------

# Configuration

Reload config:

tmux source-file \~/.tmux.conf

------------------------------------------------------------------------

# Status Bar

Only shows time and date

Format: HH:MM DD-Mon

Example: 19:42 20-Mar

------------------------------------------------------------------------

# General Settings

-   Mouse enabled\
-   History: 20,000 lines\
-   Index starts at 1

------------------------------------------------------------------------

# Summary

Minimal, fast, default tmux setup.

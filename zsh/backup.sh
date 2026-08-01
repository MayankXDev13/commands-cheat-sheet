#!/usr/bin/env bash
set -e
mkdir -p backup
cp -f ~/.zshrc backup/.zshrc 2>/dev/null || true
cp -r ~/.zsh backup/zsh 2>/dev/null || true
cp -r ~/.oh-my-zsh/custom backup/custom 2>/dev/null || true
echo "Backup complete."

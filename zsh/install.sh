#!/usr/bin/env bash
set -e
sudo apt update
sudo apt install -y zsh git curl
if [ ! -d "$HOME/.oh-my-zsh" ]; then
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions fzf-tab)
for p in "${plugins[@]}"; do
  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/$p" ]; then
    git clone https://github.com/zsh-users/$p "$HOME/.oh-my-zsh/custom/plugins/$p" || true
  fi
done
cp .zshrc "$HOME/.zshrc"
mkdir -p "$HOME/.zsh"
cp -r zsh/* "$HOME/.zsh/"
chsh -s "$(which zsh)" || true
echo "Done. Restart terminal or run: source ~/.zshrc"

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

export TERMINAL="alacritty"

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
alias cd="z"
alias n="nvim"
alias c="code"
alias nano="micro"
alias ls="eza -l"

open() {
  nohup xdg-open "$1" >/dev/null 2>&1 &
  disown
}
# opencode
export PATH=/home/datadiego/.opencode/bin:$PATH
eval "$(starship init bash)"

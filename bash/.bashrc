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

_save_cwd() {
    [[ "$PWD" != "${_cwd_last:-}" ]] && { printf '%s\n' "$PWD" > "$HOME/.cwd"; _cwd_last="$PWD"; }
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND;}'_save_cwd'

eval "$(fzf --bash)"
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
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(starship init bash)"
eval "$(zoxide init bash)"

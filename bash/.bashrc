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
alias ls="eza -la"

# Gruvbox colors for eza (ANSI 24-bit format)
EZA_COLORS="di=38;2;104;157;106:\
ex=38;2;152;151;26:\
fi=38;2;235;219;178:\
ln=38;2;131;165;152:\
lp=38;2;142;192;124:\
or=38;2;251;73;52:\
ur=38;2;235;219;178:\
uw=38;2;254;128;25:\
ux=38;2;152;151;26:\
sg=38;2;251;73;52:\
su=38;2;251;73;52:\
sn=38;2;102;92;84:\
da=38;2;168;153;132:\
*.jpg=38;2;214;93;14:\
*.jpeg=38;2;214;93;14:\
*.png=38;2;214;93;14:\
*.gif=38;2;214;93;14:\
*.bmp=38;2;214;93;14:\
*.svg=38;2;214;93;14:\
*.webp=38;2;214;93;14:\
*.ico=38;2;214;93;14:\
*.mp4=38;2;69;133;136:\
*.mkv=38;2;69;133;136:\
*.webm=38;2;69;133;136:\
*.mov=38;2;69;133;136:\
*.avi=38;2;69;133;136:\
*.mp3=38;2;104;157;106:\
*.flac=38;2;104;157;106:\
*.wav=38;2;104;157;106:\
*.m4a=38;2;104;157;106:\
*.ogg=38;2;104;157;106:\
*.zip=38;2;254;128;25:\
*.tar=38;2;254;128;25:\
*.gz=38;2;254;128;25:\
*.xz=38;2;254;128;25:\
*.bz2=38;2;254;128;25:\
*.rar=38;2;254;128;25:\
*.7z=38;2;254;128;25:\
*.zst=38;2;254;128;25"
export EZA_COLORS
open() {
  nohup xdg-open "$1" >/dev/null 2>&1 &
  disown
}
# opencode
export PATH=/home/datadiego/.opencode/bin:$PATH
eval "$(starship init bash)"
export NGINX_PATH=/usr/share/nginx/html/
export NGINX_PATH=/usr/share/nginx/html

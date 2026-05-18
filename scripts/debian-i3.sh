# Configurar git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

# update
sudo apt update -y

# utilidades
sudo apt install pipx unzip xclip yq jq fzf stow -y

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# peticiones http
sudo apt install curl wget httpie -y

#sql
sudo apt install sqlite3 sqlitebrowser -y

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
apt check-update &&
  sudo apt install code -y

# Nerd fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v

# gh cli
# TODO

# entorno javascript
sudo apt install npm nodejs -y
curl -fsSL https://bun.sh/install | bash

# docker
# TODO
# sudo usermod -aG docker $USER

# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

#neovim
sudo apt install nvim -y

#lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

wget https://github.com/Strophox/tetro-tui/releases/download/v3.1.0/tetro-tui_v3.1_x86_64-unknown-linux-gnu.zip

#tetro-tui
URL="https://github.com/Strophox/tetro-tui/releases/download/v3.1.0/tetro-tui_v3.1_x86_64-unknown-linux-gnu.zip"
TMP_DIR="$(mktemp -d)"

wget -q "$URL" -O "$TMP_DIR/tetro.zip"

unzip -q "$TMP_DIR/tetro.zip" -d "$TMP_DIR"

chmod +x "$TMP_DIR/tetro-tui"
sudo mv "$TMP_DIR/tetro-tui" /usr/local/bin/tetro-tui

rm -rf "$TMP_DIR"

pipx install csvkit

# entorno i3
sudo apt install picom -y
sudo apt install alacritty -y
sudo apt install -y arc-theme -y
sudo apt install papirus-icon-theme -y
sudo apt copr enable numix/numix -y
sudo apt install numix-icon-theme-circle -y
sudo apt install lxappearance -y
sudo apt install polybar -y
sudo apt install rofi -y

## azote
sudo apt install -y python3-pip python3-xlib libavif libavif-devel
pip install --user --upgrade pillow-heif
pip install --user --upgrade Pillow

# opencode
curl -fsSL https://opencode.ai/install | bash

# starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

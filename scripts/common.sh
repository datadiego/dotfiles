# update
sudo dnf update -y

# utilidades
sudo dnf install pipx unzip xclip yq jq fzf stow eza -y

# starship
curl -sS https://starship.rs/install.sh | sh

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# peticiones http
sudo dnf install curl wget httpie -y

#sql
sudo dnf install sqlite3 sqlitebrowser -y

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
dnf check-update &&
  sudo dnf install code -y

# Nerd fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v

# gh cli
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli -y

# entorno javascript
sudo dnf install npm nodejs -y
curl -fsSL https://bun.sh/install | bash

# go
sudo dnf install -y golang

# docker
sudo dnf remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-selinux \
  docker-engine-selinux \
  docker-engine

sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo -y
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# lazygit
sudo dnf copr enable dejan/lazygit -y
sudo dnf install lazygit -y

#neovim
sudo dnf install nvim -y

#tetro-tui
URL="https://github.com/Strophox/tetro-tui/releases/download/v3.1.0/tetro-tui_v3.1_x86_64-unknown-linux-gnu.zip"
TMP_DIR="$(mktemp -d)"
wget -q "$URL" -O "$TMP_DIR/tetro.zip"
unzip -q "$TMP_DIR/tetro.zip" -d "$TMP_DIR"
chmod +x "$TMP_DIR/tetro-tui"
sudo mv "$TMP_DIR/tetro-tui" /usr/local/bin/tetro-tui

rm -rf "$TMP_DIR"

# csvkit
pipx install csvkit

# opencode
curl -fsSL https://opencode.ai/install | bash

# Codecs (RPM Fusion + ffmpeg completo para mkv, h264, hevc, etc)
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y

# Configurar git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

sudo dnf copr enable sdegler/hyprland -y
sudo dnf install hyprland hyprpaper hyprlock hypridle hyprsunset -y

# update
sudo dnf update -y

# utilidades
sudo dnf install pipx unzip xclip yq jq fzf stow btop -y

# starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

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

#neovim
sudo dnf install nvim -y

#lazyvim
rm -rf ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Copiar init.lua personalizado de los dotfiles
DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
if [ -f "$DOTFILES_DIR/nvim/.config/nvim/init.lua" ]; then
  cp "$DOTFILES_DIR/nvim/.config/nvim/init.lua" ~/.config/nvim/init.lua
fi

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

# ===== Entorno Hyprland =====

mkdir -p ~/.local/bin

# Portal para Hyprland (org.freedesktop.impl.portal.desktop.hyprland)
sudo dnf install xdg-desktop-portal-hyprland -y

# Status bar, notificaciones, lanzador
sudo dnf install waybar mako -y

# Walker (app lanzador) - desde GitHub
WALKER_URL=$(curl -fsSL https://api.github.com/repos/abenz1267/walker/releases/latest | grep "browser_download_url.*linux.*tar.gz" | cut -d'"' -f4 | head -1)
curl -fsSL "$WALKER_URL" | tar xz -C ~/.local/bin/

# Dependencia para walker
sudo dnf install gtk4-layer-shell -y

# Elephant (backend de walker) - desde GitHub
ELEPHANT_URL=$(curl -fsSL https://api.github.com/repos/abenz1267/elephant/releases/latest | grep "browser_download_url.*linux-amd64.tar.gz" | grep "elephant-linux" | cut -d'"' -f4 | head -1)
curl -fsSL "$ELEPHANT_URL" | tar xz -C ~/.local/bin/
mv ~/.local/bin/elephant-linux-amd64 ~/.local/bin/elephant 2>/dev/null

# Providers de elephant
for PROVIDER in desktopapplications runner websearch calc clipboard files menus symbols unicode providerlist; do
  URL=$(curl -fsSL https://api.github.com/repos/abenz1267/elephant/releases/latest | grep "browser_download_url.*linux-amd64.tar.gz" | grep "${PROVIDER}-linux" | cut -d'"' -f4 | head -1)
  curl -fsSL "$URL" | tar xz -C ~/.local/bin/
  mv ~/.local/bin/${PROVIDER}-linux-amd64 ~/.local/bin/elephant-${PROVIDER} 2>/dev/null
done
mkdir -p ~/.config/elephant/plugins
mv ~/.local/bin/elephant-*.so ~/.config/elephant/plugins/ 2>/dev/null
chmod +x ~/.local/bin/elephant ~/.config/elephant/plugins/*.so 2>/dev/null

# Activar servicio de elephant
~/.local/bin/elephant service enable 2>/dev/null
sed -i "s|ExecStart=elephant|ExecStart=$HOME/.local/bin/elephant|" ~/.config/systemd/user/elephant.service 2>/dev/null
sed -i "s|graphical-session.target|default.target|g" ~/.config/systemd/user/elephant.service 2>/dev/null
systemctl --user daemon-reload 2>/dev/null
systemctl --user enable elephant.service 2>/dev/null
systemctl --user start elephant.service 2>/dev/null

# Codecs (RPM Fusion + ffmpeg completo para mkv, h264, hevc, etc)
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y

# Reproductor de vídeo (Wayland-native)
sudo dnf install mpv -y

# Terminal
sudo dnf install alacritty -y

# Gestor de archivos (nautilus)
sudo dnf install nautilus -y

# Tema oscuro para nautilus (libadwaita)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Fix: nautilus desde lanzadores (walker) en Hyprland
# Usa un wrapper script con ruta absoluta + DBusActivatable=false
mkdir -p ~/.local/bin ~/.local/share/applications
cat > ~/.local/bin/nautilus-walker << 'WRAPPER'
#!/bin/bash
exec /usr/bin/nautilus --new-window "$@"
WRAPPER
chmod +x ~/.local/bin/nautilus-walker
cp /usr/share/applications/org.gnome.Nautilus.desktop ~/.local/share/applications/
sed -i "s|Exec=nautilus --new-window %U|Exec=$HOME/.local/bin/nautilus-walker %U|" ~/.local/share/applications/org.gnome.Nautilus.desktop
sed -i "s|Exec=nautilus --new-window|Exec=$HOME/.local/bin/nautilus-walker|" ~/.local/share/applications/org.gnome.Nautilus.desktop
sed -i 's/DBusActivatable=true/DBusActivatable=false/' ~/.local/share/applications/org.gnome.Nautilus.desktop
update-desktop-database ~/.local/share/applications

# Utilidades Wayland
sudo dnf install hyprpolkitagent network-manager-applet playerctl brightnessctl pavucontrol grim slurp wl-clipboard -y

# Audio
sudo dnf install pamixer -y

# Bluetooth
sudo dnf install bluez bluez-utils -y

# GTK theming para Wayland
sudo dnf install nwg-look qt5ct qt6ct -y

# Tema GTK e iconos
sudo dnf install arc-theme papirus-icon-theme -y

# Screenshots
pipx install hyprshot

# Screenshots - grub tema (opcional)
# gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
# gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

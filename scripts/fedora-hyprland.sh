# update
sudo dnf update -y

sudo dnf copr enable sdegler/hyprland -y
sudo dnf install hyprland hyprpaper hyprlock hypridle hyprsunset -y

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
done
mkdir -p ~/.config/elephant/plugins
mv ~/.local/bin/*-linux-amd64.so ~/.config/elephant/plugins/ 2>/dev/null
chmod +x ~/.local/bin/elephant ~/.config/elephant/plugins/*.so 2>/dev/null

# Activar servicio de elephant
~/.local/bin/elephant service enable 2>/dev/null
sed -i "s|ExecStart=elephant|ExecStart=$HOME/.local/bin/elephant|" ~/.config/systemd/user/elephant.service 2>/dev/null
sed -i "s|graphical-session.target|default.target|g" ~/.config/systemd/user/elephant.service 2>/dev/null
systemctl --user daemon-reload 2>/dev/null
systemctl --user enable elephant.service 2>/dev/null
systemctl --user start elephant.service 2>/dev/null

# Fix: vars de entorno para servicios de usuario
# elephant, waybar, y otros servicios systemd --user no heredan
# el PATH del shell ni las vars de display. Se configuran aquí
# para que funcionen al arrancar antes que Hyprland.
mkdir -p ~/.config/environment.d
cat >~/.config/environment.d/90-env.conf <<'ENVEOF'
# Asegura vars de display para servicios de usuario que arrancan
# antes que Hyprland establezca el entorno gráfico.
WAYLAND_DISPLAY=wayland-1
DISPLAY=:0
XDG_SESSION_TYPE=wayland

# PATH completo para que waybar, bindings de Hyprland y lanzadores
# encuentren binarios instalados en ~/.local/bin/ (impala, walker, lazydocker, etc.)
PATH=${HOME}/.local/bin:${PATH}
ENVEOF
systemctl --user set-environment WAYLAND_DISPLAY=wayland-1
systemctl --user set-environment DISPLAY=:0
systemctl --user set-environment XDG_SESSION_TYPE=wayland
systemctl --user set-environment PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/usr/sbin"
systemctl --user restart elephant.service

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
cat >~/.local/bin/nautilus-walker <<'WRAPPER'
#!/bin/bash
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1}
export DISPLAY=${DISPLAY:-:0}
export XDG_SESSION_TYPE=${XDG_SESSION_TYPE:-wayland}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
exec /usr/bin/nautilus --new-window "$@"
WRAPPER
chmod +x ~/.local/bin/nautilus-walker
cp /usr/share/applications/org.gnome.Nautilus.desktop ~/.local/share/applications/
sed -i "s|Exec=nautilus --new-window %U|Exec=$HOME/.local/bin/nautilus-walker %U|" ~/.local/share/applications/org.gnome.Nautilus.desktop
sed -i "s|Exec=nautilus --new-window|Exec=$HOME/.local/bin/nautilus-walker|" ~/.local/share/applications/org.gnome.Nautilus.desktop
sed -i 's/DBusActivatable=true/DBusActivatable=false/' ~/.local/share/applications/org.gnome.Nautilus.desktop
update-desktop-database ~/.local/share/applications

# Utilidades Wayland
sudo dnf install hyprpolkitagent playerctl brightnessctl pavucontrol grim slurp wl-clipboard -y

# Audio
sudo dnf install pamixer -y

# Bluetooth
sudo dnf install bluez bluez-utils -y

# Network (iwd + impala)
sudo dnf install iwd -y

# Impala (TUI para iwd, reemplaza nm-applet)
curl -fsSL https://github.com/pythops/impala/releases/download/v0.7.4/impala-x86_64-unknown-linux-musl \
  -o ~/.local/bin/impala
chmod +x ~/.local/bin/impala

# GTK theming para Wayland
sudo dnf install nwg-look qt5ct qt6ct -y

# Tema GTK e iconos
sudo dnf install arc-theme papirus-icon-theme -y

# Screenshots
pipx install hyprshot

# ===== CAMBIO A NETWORKMANAGER + IWD (AL FINAL: REQUIERE REBOOT) =====
# Se configura NetworkManager para usar iwd como backend WiFi.
sudo systemctl enable --now iwd

mkdir -p /etc/NetworkManager/conf.d
echo '[device]
wifi.backend=iwd' | sudo tee /etc/NetworkManager/conf.d/wifi-backend.conf >/dev/null

sudo systemctl restart NetworkManager

echo ""
echo "✓ iwd activado. NetworkManager configurado para usar iwd como backend WiFi."
echo "✓ impala instalado en ~/.local/bin/impala"
echo ""
echo "⚠ REINICIA el sistema para que todos los cambios surtan efecto."
echo "   Tras el reinicio: la señal WiFi se verá en waybar y"
echo "   el click abre impala (TUI) para gestionar redes."
echo ""

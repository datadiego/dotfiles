# update
sudo dnf update -y

# entorno i3
sudo dnf install i3 -y
sudo dnf install picom -y
sudo dnf install alacritty -y
sudo dnf install -y arc-theme -y
sudo dnf install papirus-icon-theme -y
sudo dnf copr enable numix/numix -y
sudo dnf install numix-icon-theme-circle -y
sudo dnf install lxappearance -y
sudo dnf install polybar -y
sudo dnf install rofi -y

## azote
sudo dnf install -y python3-pip python3-xlib libavif libavif-devel
pip install --user --upgrade pillow-heif
pip install --user --upgrade Pillow

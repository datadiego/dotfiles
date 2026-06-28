sudo dnf upgrade --refresh -y
sudo dnf upgrade -y
sudo dnf copr enable avengemedia/dms -y
sudo dnf install dms -y
curl -fsSL https://install.danklinux.com | sh
dms greeter install

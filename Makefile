SHELL := /bin/bash

PACKAGES := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi btop starship fastfetch
PACKAGES_I3 := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi btop starship fastfetch user-scripts
PACKAGES_GNOME := bash nvim btop starship fastfetch user-scripts
PACKAGES_HYPRLAND := alacritty applications bash gtk-3.0 hypr waybar walker mako profile wallpaper btop starship fastfetch user-scripts
PACKAGES_DMS := bash dms-hyprland DankMaterialShell nvim fastfetch dms-alacritty wallpapers user-scripts

#PHONY hace que siempre se ejecute la accion asociada en el Makefile
.PHONY: help fedora-hyprland fedora-gnome fedora-i3 fedora-dms install-fedora-i3 install-fedora-hyprland install-debian-i3 install-fedora-dms install-fedora-common fedora-hacking debian-hacking git-config stow-gnome stow-i3 stow-hyprland stow-dms unstow generate clean

help:
	@cat logo
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

fedora-hyprland: git-config install-fedora-common install-fedora-hyprland generate stow-hyprland clean  ## Configuración básica fedora + hyprland

fedora-gnome: git-config install-fedora-common stow-gnome clean ## Configuración básica fedora + gnome

fedora-i3: git-config install-fedora-common install-fedora-i3 stow-i3 clean ## Configuración básica fedora + i3

fedora-dms: git-config install-fedora-common install-fedora-dms stow-dms clean ## Configuración básica fedora + dank material shell

install-fedora-i3:
	@bash scripts/fedora-i3.sh

install-debian-i3:
	@bash scripts/debian-i3.sh
	@rm -f ~/.profile

install-fedora-hyprland:
	@bash scripts/fedora-hyprland.sh

install-fedora-dms:
	@bash scripts/fedora-dms.sh

install-fedora-common:
	@bash scripts/fedora-common.sh

fedora-hacking: ## Herramientas de hacking y ciberseguridad para fedora
	@bash scripts/cybsec-tools-fedora.sh

debian-hacking: ## Herramientas de hacking y ciberseguridad para debian
	@bash scripts/cybsec-tools-debian.sh

git-config:
	@bash scripts/git-config.sh

stow-gnome:
	@rm -f ~/.bashrc
	@rm -rf ~/.config/nvim
	@for pkg in $(PACKAGES_GNOME); do \
		echo "Stowing $$pkg..."; \
		stow -S "$$pkg"; \
	done

stow-i3:
	@rm -f ~/.bashrc
	@rm -rf ~/.config/nvim
	@for pkg in $(PACKAGES_I3); do \
		echo "Stowing $$pkg..."; \
		stow -S "$$pkg"; \
	done

stow-hyprland:
	@rm -f ~/.bashrc
	@rm -rf ~/.config/nvim
	@for pkg in $(PACKAGES_HYPRLAND); do \
		echo "Stowing $$pkg..."; \
		stow -R "$$pkg"; \
	done

stow-dms:
	@rm -f ~/.bashrc
	@rm -rf ~/.config/nvim
	@rm -rf ~/.config/DankMaterialShell/
	@rm -rf ~/.config/hypr/
	@rm -rf ~/.config/alacritty
	@for pkg in $(PACKAGES_DMS); do \
		echo "Stowing $$pkg..."; \
		stow -R "$$pkg"; \
	done

stow-%:
	@echo "Stowing $*..."
	@stow -v "$*"

unstow:  ## Unstow todos los paquetes
	@for pkg in $(PACKAGES); do \
		echo "Unstowing $$pkg..."; \
		stow -v -D "$$pkg"; \
	done

unstow-%:  ## Unstow un paquete específico (ej: make unstow-alacritty)
	@echo "Unstowing $*..."
	@stow -v -D "$*"

generate:  ## Genera configs desde templates
	@bash generate.sh

clean:  ## Limpia archivos generados
	@rm -f alacritty/.config/alacritty/alacritty.toml
	@rm -f i3/.config/i3/config
	@rm -f *.zip
	@echo "Archivos generados eliminados"

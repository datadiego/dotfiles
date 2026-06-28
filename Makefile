SHELL := /bin/bash

PACKAGES := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi btop starship fastfetch
PACKAGES_I3 := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi btop starship fastfetch
PACKAGES_GNOME := bash nvim btop starship fastfetch
PACKAGES_HYPRLAND := alacritty applications bash gtk-3.0 hypr waybar walker mako profile wallpaper btop starship fastfetch
PACKAGES_DMS := bash dms-hyprland DankMaterialShell nvim fastfetch

#PHONY hace que siempre se ejecute la accion asociada en el Makefile
.PHONY: help fedora-basic fedora-i3 fedora-hyprland setup-hyprland setup-gnome setup-i3 setup-dms stow unstow generate status clean

help:  ## Muestra esta ayuda
	@echo "Dotfiles"
	@echo "Primero utiliza una de las opciones de instalar las dependencias necesarias"
	@echo "Luego usa la opción de stow correspondiente"
	@echo "=================="
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup-hyprland: git-config fedora-common fedora-hyprland generate stow-hyprland  ## Configuración básica fedora + hyprland

setup-gnome: git-config fedora-common stow-gnome ## Configuración básica fedora + gnome

setup-fedora-i3: git-config fedora-common fedora-i3 stow-i3 ## Configuración básica fedora + i3

setup-dms: git-config fedora-common fedora-dms stow-dms ## Configuración básica fedora + dank material shell

fedora-i3:  ## Instala dependencias para Fedora i3
	@bash scripts/fedora-i3.sh

fedora-hyprland:  ## Instala dependencias para Fedora Hyprland
	@bash scripts/fedora-hyprland.sh

debian-i3:  ## Instala dependencias para Debian i3
	@bash scripts/debian-i3.sh
	@rm ~/.profile

git-config: ## Instala herramientas comunes en fedora
	@bash scripts/git-config.sh

fedora-common: ## Instala herramientas comunes en fedora
	@bash scripts/common.sh

stow-gnome: ## Stow de paquetes para GNOME
	@rm ~/.bashrc
	@rm -rf ~/.config/nvim
	@for pkg in $(PACKAGES_GNOME); do \
		echo "Stowing $$pkg..."; \
		stow -S "$$pkg"; \
	done

stow-i3: ## Stow de paquetes para i3
	@rm ~/.bashrc
	@rm -rf ~/.config/nvim
	@for pkg in $(PACKAGES_I3); do \
		echo "Stowing $$pkg..."; \
		stow -S "$$pkg"; \
	done

stow-hyprland: ## Stow de paquetes para Hyprland
	@rm ~/.bashrc
	@rm -rf ~/.config/nvim
	@for pkg in $(PACKAGES_HYPRLAND); do \
		echo "Stowing $$pkg..."; \
		stow -R "$$pkg"; \
	done

stow-dms: ## Stow de paquetes para DankMaterialShell
	@rm ~/.bashrc
	@rm -rf ~/.config/nvim
	@rm -rf ~/.config/DankMaterialShell/
	@for pkg in $(PACKAGES_DMS); do \
		echo "Stowing $$pkg..."; \
		stow -R "$$pkg"; \
	done

stow-%:  ## Stow un paquete específico (ej: make stow-alacritty)
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
	@echo "Archivos generados eliminados"

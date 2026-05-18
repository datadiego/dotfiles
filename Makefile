SHELL := /bin/bash

PACKAGES := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi btop starship fastfetch
PACKAGES_I3 := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi btop starship fastfetch
PACKAGES_GNOME := bash nvim btop starship fastfetch

#PHONY hace que siempre se ejecute la accion asociada en el Makefile
.PHONY: help fedora-basic fedora-i3 stow unstow generate status clean

help:  ## Muestra esta ayuda
	@echo "Dotfiles"
	@echo "Primero utiliza una de las opciones de instalar las dependencias necesarias"
	@echo "Luego usa la opción de stow correspondiente"
	@echo "=================="
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

fedora-gnome:  ## Instala dependencias para Fedora GNOME
	@bash scripts/fedora-gnome.sh

fedora-i3:  ## Instala dependencias para Fedora i3
	@bash scripts/fedora-i3.sh

debian-i3:  ## Instala dependencias para Debian i3
	@bash scripts/debian-i3.sh
	@rm -rf ~/.config/nvim/
	@rm ~/.bashrc
	@rm ~/.profile

stow-gnome: ## Stow de paquetes para GNOME
	@for pkg in $(PACKAGES_GNOME); do \
		echo "Stowing $$pkg..."; \
		stow -S "$$pkg"; \
	done

stow-i3: ## Stow de paquetes para Fedora i3
	@for pkg in $(PACKAGES_I3); do \
		echo "Stowing $$pkg..."; \
		stow -S "$$pkg"; \
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

#status:  ## Muestra el estado de los paquetes stow
#	@for pkg in $(PACKAGES); do \
#		case $$pkg in \
#			profile) target=~/.profile ;; \
#			bash) target=~/.bashrc ;; \
#			*) target=~/.config/$$pkg ;; \
#		esac; \
#		if [ -L "$$target" ]; then \
#			echo "✓ $$pkg"; \
#		else \
#			echo "✗ $$pkg"; \
#		fi \
#	done

clean:  ## Limpia archivos generados
	@rm -f alacritty/.config/alacritty/alacritty.toml
	@rm -f i3/.config/i3/config
	@echo "Archivos generados eliminados"

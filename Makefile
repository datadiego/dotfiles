SHELL := /bin/bash

PACKAGES := alacritty bash gtk-3.0 i3 i3status nvim profile wallpaper picom polybar rofi

#PHONY hace que siempre se ejecute la accion asociada en el Makefile
.PHONY: help fedora-basic fedora-i3 stow unstow generate status clean

help:  ## Muestra esta ayuda
	@echo "Dotfiles Management"
	@echo "=================="
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

fedora-basic:  ## Instala dependencias para Fedora GNOME
	@bash scripts/fedora-basic.sh

fedora-i3:  ## Instala dependencias para Fedora i3
	@bash scripts/fedora-i3.sh

stow:  ## Stow todos los paquetes
	@for pkg in $(PACKAGES); do \
		echo "Stowing $$pkg..."; \
		stow -v "$$pkg"; \
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

status:  ## Muestra el estado de los paquetes stow
	@for pkg in $(PACKAGES); do \
		case $$pkg in \
			profile) target=~/.profile ;; \
			bash) target=~/.bashrc ;; \
			*) target=~/.config/$$pkg ;; \
		esac; \
		if [ -L "$$target" ]; then \
			echo "✓ $$pkg"; \
		else \
			echo "✗ $$pkg"; \
		fi \
	done

clean:  ## Limpia archivos generados
	@rm -f alacritty/.config/alacritty/alacritty.toml
	@rm -f i3/.config/i3/config
	@echo "Archivos generados eliminados"

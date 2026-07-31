SHELL := /bin/bash

# Overrides de perfil para chezmoi (--override-data)
PROFILE_COMMON   := {"profile": "common"}
PROFILE_I3       := {"profile": "i3"}
PROFILE_HYPRLAND := {"profile": "hyprland"}
PROFILE_DMS      := {"profile": "dms"}

.PHONY: help init fedora-common fedora-hyprland fedora-dms install-fedora-common install-fedora-hyprland install-fedora-dms fedora-hacking debian-hacking git-config apply apply-common apply-i3 apply-hyprland apply-dms update status diff clean

help:
	@cat logo
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

init: ## Primer arranque: crea la config y pregunta el perfil
	@chezmoi init

fedora-common: git-config install-fedora-common apply-common clean ## Configuración básica fedora + gnome

fedora-hyprland: git-config install-fedora-common install-fedora-hyprland apply-hyprland clean ## Configuración básica fedora + hyprland

fedora-dms: git-config install-fedora-common install-fedora-dms apply-dms clean ## Configuración básica fedora + dank material shell

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

apply: ## Aplica el perfil guardado en la config de chezmoi
	@chezmoi apply

apply-common: ## Aplica el perfil common
	@chezmoi apply --override-data '$(PROFILE_COMMON)'

apply-i3: ## Aplica el perfil i3
	@chezmoi apply --override-data '$(PROFILE_I3)'

apply-hyprland: ## Aplica el perfil hyprland
	@chezmoi apply --override-data '$(PROFILE_HYPRLAND)'

apply-dms: ## Aplica el perfil dms
	@chezmoi apply --override-data '$(PROFILE_DMS)'

update: ## Actualiza los dotfiles desde el remoto y aplica
	@chezmoi update

status: ## Muestra el estado de los dotfiles
	@chezmoi status

diff: ## Muestra las diferencias
	@chezmoi diff

clean: ## Limpia archivos generados
	@rm -f *.zip
	@echo "Archivos generados eliminados"

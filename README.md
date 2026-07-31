# dotfiles

Mi colección personal de dotfiles, gestionada con [chezmoi](https://www.chezmoi.io/).

## Requisitos

- `make`
- `chezmoi` ([instalación oficial](https://www.chezmoi.io/docs/install/))

## Como usarlos

Usa `make` para ver las opciones disponibles.

Primer arranque:

```bash
make init          # clona este repo como fuente y pregunta el perfil a usar
make apply         # aplica el perfil guardado en la config
```

El perfil se elige durante `make init` (o `chezmoi init`) y se guarda en
`~/.config/chezmoi/chezmoi.toml`. Puedes forzar un perfil concreto en cualquier
momento:

```bash
make apply-common     # perfil básico (gnome)
make apply-i3         # perfil i3
make apply-hyprland   # perfil hyprland
make apply-dms        # perfil dank material shell
```

Actualizar desde el remoto:

```bash
make update           # equivale a chezmoi update
```

## Entornos

### Fedora Hyprland

Entorno de hyprland + waybar + walker + impala.

### Fedora Dank Material Shell

Entorno personalizado a partir de Dank Material Shell, más pesado que `Fedora Hyprland`, pero con muchas más facilidades de personalización.

### Fedora Gnome

Utilidades básicas para mejorar el uso del sistema partiendo de una instalación básica de Fedora con gnome.

### Fedora i3

Entorno básico de i3, pensado para equipos menos potentes o VMs.

## Instalación completa (dependencias + dotfiles)

```bash
make fedora-common     # fedora + gnome
make fedora-hyprland   # fedora + hyprland
make fedora-dms        # fedora + dank material shell
```

Estos targets instalan las dependencias (`scripts/*.sh`), aplican el perfil con
chezmoi y limpian los archivos descargados.

## Estructura

La fuente de chezmoi usa el prefijo `dot_` para los archivos ocultos:

- `dot_bashrc.tmpl` → `~/.bashrc` (template según el OS)
- `dot_config/` → `~/.config/`
- `dot_local/` → `~/.local/`
- `dot_inputrc` → `~/.inputrc`
- `dot_profile` → `~/.profile`
- `.chezmoi.toml.tmpl` → genera la config de chezmoi (pregunta el perfil)
- `.chezmoiignore.tmpl` → selecciona los archivos de cada perfil

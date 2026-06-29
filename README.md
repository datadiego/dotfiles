# dotfiles

Esta es mi colección personal de dotfiles, gestionada con `stow`.

## Como usarlos

Necesitarás `make` para poder ejecutar los diferentes scripts de dependencias y la configuración de los dotfiles.

Usa `make` para ver las diferentes opciones y para instalar las dependencias y mover los dotfiles necesarios.

```bash
dotfiles on  master [!⇡]
❯ make
     __     __  ____ __
 ___/ /__  / /_/ _(_) /__ ___
/ _  / _ \/ __/ _/ / / -_|_-<
\_,_/\___/\__/_//_/_/\__/___/

  fedora-hyprland Configuración básica fedora + hyprland
  fedora-gnome    Configuración básica fedora + gnome
  fedora-i3       Configuración básica fedora + i3
  fedora-dms      Configuración básica fedora + dank material shell
  fedora-hacking  Herramientas de hacking y ciberseguridad para fedora
  debian-hacking  Herramientas de hacking y ciberseguridad para debian
  unstow          Unstow todos los paquetes
  generate        Genera configs desde templates
  clean           Limpia archivos generados

dotfiles on  master [!⇡]
❯ make fedora-dms
```

## Entornos

### Fedora Hyprland

Entorno de hyprland + waybar + walker + impala.

Funcional pero básico, tiene lo justo para personalizarlo a tu gusto.

### Fedora Dank Material Shell

Entorno personalizado a partir de Dank Material Shell, más pesado que `Fedora Hyprland`, pero con muchas más facilidades de personalización.

### Fedora Gnome

Utilidades básicas para mejorar el uso del sistema partiendo de una instalación básica de Fedora con gnome.

### Fedora i3

Entorno básico de i3, pensado para equipos menos potentes o VMs.

## Paquetes

Todos los entornos incluyen:

- `xclip`: Copia la respuesta de la terminal directamente a tu portapapeles
- `yq`: Analiza y manipula archivos `yaml` desde CLI
- `jq`: Analiza y manipula `JSON` desde CLI
- `fzf`: Encuentra archivos y rutas rápidamente desde el CLI
- `eza`: Sustituye `ls` para una salida más moderna
- `tldr`: Referencia rápida para consultar comandos
- `zoxide`: Moverte a carpetas sin escribir la ruta completa
- `httpie`: Cliente http
- `nvim + lazyvim`: Editor de código ligero
- `gh + lazygit`: Interactua con tus repositorios en github desde CLI y TUI
- `docker + lazydocker`: Crea y gestiona tus contenedores de docker con un TUI
- `tetro-tui`: La mejor implementación de tetris para terminal
- `csvkit`: Analiza y manipula `csv`
- `opencode`: Agente de inteligencia artificial
- `nodejs + pnpm + bun`: Desarrolla proyectos de javascript/typescript
- `golang`: Desarrolla e instala herramientas con Go
- `uv + python`: Desarrolla proyectos de python desde `uv`

Adicionalmente, puedes hacer `make fedora-hacking` para instalar un pack de herramientas básicas para hacking y ciberseguridad.

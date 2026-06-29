# dotfiles

Esta es mi colección personal de dotfiles, gestionada con `stow`.

## Como usarlos

Necesitarás `make` para poder ejecutar los diferentes scripts de dependencias y la configuración de los dotfiles.

Usa `make` para ver las diferentes opciones y para instalar las dependencias y mover los dotfiles necesarios.

```bash
dotfiles master  ? ❯ make
     __     __  ____ __
 ___/ /__  / /_/ _(_) /__ ___
/ _  / _ \/ __/ _/ / / -_|_-<
\_,_/\___/\__/_//_/_/\__/___/

Dotfiles para entornos de desarrollo
  fedora-hyprland Configuración básica fedora + hyprland
  fedora-gnome    Configuración básica fedora + gnome
  fedora-i3       Configuración básica fedora + i3
  fedora-dms      Configuración básica fedora + dank material shell
  unstow          Unstow todos los paquetes
  generate        Genera configs desde templates
  clean           Limpia archivos generados
dotfiles master  ? ❯ make fedora-gnome
```



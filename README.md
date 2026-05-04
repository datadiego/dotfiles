# dotfiles

Esta es mi colección personal de dotfiles, gestionada con `stow`.

## Como usarlos

Necesitarás `make` para poder ejecutar los diferentes scripts de dependencias y la configuración de los dotfiles.

Usa `make help` para ver las diferentes opciones a instalar.

Comienza por elegir un script para instalar tus dependencias, esto dependerá de tu distribución y el entorno de escritorio que prefieras.

- `fedora-basic`: Herramientas básicas y utilidades varias, pensada para ejecutarse en **Fedora GNOME**
- `fedora-i3`: Herramientas básicas y configuraciones para ejecutarse en el spin de **Fedora i3**.

Una vez tengas las dependencias necesarias, usa `stow` para crear tus dotfiles:

- `generate`: Genera dotfiles desde las plantillas mediante `envsubst`.
- `stow`: Instala los dotfiles mediante `stow`.



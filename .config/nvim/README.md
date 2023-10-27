# Introducción

Esta es la configuración de **Neovim** de _Nedd Chairi Muñoz_, hecha completamente con **Lua** y creada en _Windows_.

Es probable que algunos accesos directos no funcionen en Linux o MacOS. Aunque pronto quiero solucionar eso.

Siéntete libre de descargarte los archivos y probarlos.

### Mini índice:

- Previa instalación
      - Neovim
  - Packer
  - Node.JS
  - Nerd Fonts
- Mapeos de teclado

---

# Previa instalación

Importante realizar estos pasos, sino no va a funcionar.

## Instalar Neovim

#### Windows:

```
choco install neovim
```

Si quieres actualizar Neovim:

```
choco uninstall neovim
choco install neovim
```

#### Linux:

##### Instalar Neovim (Arch):

```
sudo pacman -S neovim
```

##### Instalar Neovim (Debian):

```
sudo apt-get install neovim
```

##### Instalar Neovim (Ubuntu):

```
sudo apt install neovim
```

## Instalar Packer

#### Windows:

```
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

#### Linux y Unix:

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Instalar Node.JS

Es importante que tengamos bajado _Node.JS_ para algunas funcionalidades en nuestro Neovim.

[Descarga Node.JS](https://nodejs.org/es/download/)

Dependiendo de tu distribución de linux también podrás descargarlo desde la terminal. En mi caso, como suelo usar Manjaro, dejo aqui cómo se instala para distribuciones Arch.

### Arch Linux

```
sudo pacman -S nodejs npm
```

## Instalar las fuentes

Es necesario instalar una **Nerd Hack font**, para que se puedan ver bien los gráficos y además se vea más chulo.

[Descarga una Nerd Fonts](https://www.nerdfonts.com)

---

# Mapeos de teclado

### Funciones importantes:

| **Función**          | **Atajo** |
| -------------------- | --------- |
| Árbol de directorios | Alt + g   |
| Guardado de archivo  | Ctrl + s  |
| Formatear documento  | Alt + a   |
| Pestaña anterior     | Ctrl + o  |
| Pestaña siguiente    | Ctrl + p  |
| Saltar a una palabra | Alt + y   |
| Telescope            | Alt + t   |
| On/Off Autopairs     | Alt + p   |

### Caracteres rápidos:

#### Mano izquierda

| **Caracter** | **Atajo** |
| ------------ | --------- |
| +            | Alt + j   |
| -            | Alt + k   |
| \*           | Alt + m   |
| /            | Alt + ,   |
| %            | Alt + h   |
| =            | Alt + l   |
| '            | Alt + u   |
| "            | Alt + i   |
| $            | Alt + o   |
| Esc          | Alt + ñ   |

#### Mano derecha

| **Caracter** | **Atajo** |
| ------------ | --------- |
| \|           | Alt + q   |
| &            | Alt + w   |
| {            | Alt + a   |
| }            | Alt + s   |
| (            | Alt + d   |
| )            | Alt + f   |
| <            | Alt + z   |
| >            | Alt + x   |
| [            | Alt + c   |
| ]            | Alt + v   |

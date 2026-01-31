Configuración personal para **WSL2/Ubuntu** con herramientas: Neovim (NvChad), Tmux, Zsh (Oh My Zsh), Starship, Yazi, y más.

## 📦 Estructura del Repositorio

```
dotfiles/
├── nvim/          # Configuración de Neovim (NvChad)
├── tmux/          # Configuración de Tmux con TPM
├── zsh/           # .zshrc con Oh My Zsh, plugins y aliases
├── starship/      # Prompt personalizado
├── yazi/          # File manager con temas (Kanagawa, Catppuccin, Flexoki)
├── scripts/       # Script post-install.sh automatizado
└── .stow-local-ignore
```

## 🚀 Instalación Rápida

### 1️⃣ **Preparación del Sistema**

```bash
sudo apt update && sudo apt install -y build-essential curl git xclip stow
```

### 2️⃣ **Instalar Homebrew**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "
$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### 3️⃣ **Clonar este Repositorio**

```bash
git clone https://github.com/marcosllinares/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 4️⃣ **Instalar Herramientas con Homebrew**

```bash
brew install nvim tmux starship yazi lazygit fzf ripgrep tree eza fd bat
```

### 5️⃣ **Configurar Zsh y Oh My Zsh**

#### Instalar Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Instalar plugins de terceros:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```

#### Instalar Transient Prompt (para prompts limpios):
```bash
# Plugin específico para el prompt limpio
brew tap olets/tap
brew install olets/tap/zsh-transient-prompt
```

### 6️⃣ **Aplicar Dotfiles con GNU Stow**

> ⚠️ **IMPORTANTE:** Stow fallará si ya existen archivos/carpetas. Elimina o respalda los defaults antes:

```bash
cd ~/dotfiles

# Aplicar configuraciones con Stow
stow zsh
stow tmux
stow starship
stow yazi
stow nvim
```

### 7️⃣ **Post-Instalación**

Ejecuta el script automatizado (instala TPM, NvChad, configura fzf):

```bash
bash ~/dotfiles/scripts/post-install.sh
```

O hazlo manualmente:

#### **Tmux Plugin Manager (TPM):**
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Luego dentro de tmux: Prefix (Alt+f) + I para instalar plugins
```

#### **NvChad:**
```bash
git clone --depth 1 https://github.com/NvChad/NvChad ~/.config/nvim
nvim  # Espera a que Lazy instale todos los plugins
```

#### **Fzf (keybindings):**
```bash
yes | ~/.fzf/install --key-bindings --completion --no-update-rc
```

### 8️⃣ **Reiniciar la Shell**

```bash
exec zsh
```

## ⚠️ Advertencias Importantes

### 🖥️ **Si instalas en múltiples máquinas:**

1. **Aliases específicos de máquina** en `zsh/.zshrc`:
   ```bash
   # Estas rutas pueden variar entre portátil y PC torre
   alias cdunitypc='cd /mnt/e/UnityProjects'
   alias cdunityportatil='cd /mnt/d/UnityProjects'
   ```
   ✏️ **Edita las letras de unidad según tu sistema** (comprueba con `lsblk` o `df -h`)

2. **Transient Prompt:**
   - El archivo `~/.config/zsh-transient-prompt/transient-prompt.zsh-theme` **NO está en este repo**
   - Debes instalarlo manualmente o comentar las líneas 96-102 de `.zshrc`

3. **Colores de Tmux:**
   - La configuración actual asume **terminal con fondo negro**
   - Si usas fondo claro, ajusta las líneas 94-97 de `.tmux.conf`


## 🔧 Configuraciones Destacadas

### **Neovim (NvChad v2.5)**
- LSP configurado para múltiples lenguajes
- Autocompletado con `nvim-cmp`
- Plugins: Harpoon, Telescope, Treesitter, etc.
- Leader key: `<Space>`

### **Tmux**
- Prefix: `Alt + f`
- Plugins: resurrect, continuum, vim-tmux-navigator
- Guardado automático cada 15 minutos
- Zoom panel: `Ctrl + f` (sin prefix)

### **Zsh**
- Tema: Starship con prompt transiente
- Plugins: git, autosuggestions, syntax-highlighting, history-substring-search
- Función `y()`: Wrapper de Yazi para cambiar directorio al salir
- Atajo `Ctrl + P`: Copiar directorio actual al portapapeles

### **Yazi**
- Temas incluidos: Kanagawa Dragon, Catppuccin Mocha, Flexoki Dark
- Plugins: full-border, no-status

## 🛠️ Solución de Problemas

### Stow devuelve error "conflicts"
```bash
# Elimina el archivo/carpeta que causa conflicto
rm ~/.zshrc  # O el archivo que mencione el error
stow zsh     # Vuelve a intentar
```

### Tmux no carga los plugins
```bash
# Reinstalar TPM
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Dentro de tmux: Alt+f + I
```

### Neovim no encuentra LSPs
```bash
# Dentro de nvim
:MasonInstallAll
```


Configuración personal de uso libre. Los temas y plugins de terceros mantienen sus licencias originales (ver archivos LICENSE en subdirectorios).

---

**¿Problemas o sugerencias?** Abre un issue o PR 🚀

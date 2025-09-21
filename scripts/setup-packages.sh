#!/usr/bin/env bash
set -euo pipefail

# --- Helpers ---------------------------------------------------------------
is_cmd() { command -v "$1" >/dev/null 2>&1; }

install_apt() {
  sudo apt update
  sudo apt install -y "$@"
}

install_brew() {
  brew install "$@"
}

ensure_pkg() {
  local name="$1"; shift
  if is_cmd "$name"; then
    echo "[=] $name ya instalado"
    return 0
  fi

  if is_cmd brew; then
    echo "[*] Instalando $name con Homebrew..."
    install_brew "$name" || true
  fi

  if ! is_cmd "$name"; then
    echo "[*] Instalando $name con APT..."
    case "$name" in
      neovim) install_apt neovim ;;
      tmux) install_apt tmux ;;
      zsh) install_apt zsh ;;
      stow) install_apt stow ;;
      ripgrep) install_apt ripgrep ;;
      tree) install_apt tree ;;
      fzf) install_apt fzf ;;
      delta) install_apt git-delta || install_apt delta || true ;;
      lazygit)
        # APT suele estar desactualizado; intenta brew primero. Si no hay, usa el .deb oficial si existe
        install_apt lazygit || {
          echo "[!] No encontré lazygit en APT. Instálalo con brew (recomendado): brew install lazygit"
        }
        ;;
      yazi)
        # Mejor con brew por versiones; si no hay brew, usa script oficial
        if is_cmd brew; then brew install yazi; else
          echo "[*] Instalando yazi con script oficial..."
          curl -fsSL https://raw.githubusercontent.com/sxyazi/yazi/main/install.sh | bash
          # mover a ~/.local/bin si hace falta
          mkdir -p "$HOME/.local/bin"
          [ -f ./yazi-x86_64-unknown-linux-gnu ] && mv -f ./yazi-* "$HOME/.local/bin/yazi" || true
          echo "export PATH=\"$HOME/.local/bin:\$PATH\"" >> "$HOME/.profile"
        fi
        ;;
      clang) install_apt clang clangd clang-format ;;
      cmake) install_apt cmake ;;
      ninja) install_apt ninja-build ;;
      gdb) install_apt gdb ;;
      xclip) install_apt xclip ;;
      wslu) install_apt wslu ;;
      *)
        install_apt "$name"
        ;;
    esac
  fi

  if ! is_cmd "$name"; then
    echo "[!] No pude instalar $name automáticamente. Revisa el log."
  fi
}

# --- Base system deps (build tools para pyenv y otros) ---------------------
echo "[*] Instalando dependencias base para compilación (pyenv, etc.)..."
install_apt \
  build-essential curl git ca-certificates gnupg software-properties-common \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
  liblzma-dev

# --- Preferencias de instalación ------------------------------------------
# Si hay brew, actualiza fórmulas (no obligatorio, pero útil)
if is_cmd brew; then
  echo "[*] Homebrew detectado. Actualizando fórmulas..."
  brew update || true
fi

# --- Paquetes principales --------------------------------------------------
ensure_pkg zsh
ensure_pkg stow
ensure_pkg tmux
ensure_pkg neovim
ensure_pkg yazi
ensure_pkg lazygit
ensure_pkg fzf
ensure_pkg ripgrep
ensure_pkg tree
ensure_pkg delta
ensure_pkg clang
ensure_pkg cmake
ensure_pkg ninja
ensure_pkg gdb
ensure_pkg xclip
ensure_pkg wslu

# --- Starship --------------------------------------------------------------
if ! is_cmd starship; then
  if is_cmd brew; then
    echo "[*] Instalando starship (brew)..."
    brew install starship
  else
    echo "[*] Instalando starship (script oficial)..."
    curl -fsSL https://starship.rs/install.sh | bash -s -- -y
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
  fi
else
  echo "[=] starship ya instalado"
fi

# --- Oh My Zsh (si no está) -----------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[*] Instalando Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
else
  echo "[=] Oh My Zsh ya instalado"
fi

# --- pyenv -----------------------------------------------------------------
if ! is_cmd pyenv; then
  echo "[*] Instalando pyenv..."
  git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
  # init en zshrc si no existe
  if ! grep -q 'PYENV_ROOT' "$HOME/.zshrc" 2>/dev/null; then
    cat >> "$HOME/.zshrc" <<'RC'
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
RC
  fi
else
  echo "[=] pyenv ya instalado"
fi

# --- Default shell -> zsh --------------------------------------------------
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "[*] Estableciendo zsh como shell por defecto..."
  chsh -s "$(command -v zsh)" || echo "[!] No pude cambiar shell (WSL suele requerir reinicio de terminal)."
fi

# --- Summary ---------------------------------------------------------------
echo
echo "[✓] setup-packages completado."
echo "    Abre una nueva terminal o ejecuta: source ~/.zshrc"

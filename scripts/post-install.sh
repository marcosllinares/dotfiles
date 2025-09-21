#!/usr/bin/env bash
set -euo pipefail

is_cmd() { command -v "$1" >/dev/null 2>&1; }

# --- TPM (tmux plugin manager) --------------------------------------------
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "[*] Instalando TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "[=] TPM ya presente"
fi

# Instalar plugins de tmux sin abrir tmux interactivo
if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  echo "[*] Instalando plugins de tmux con TPM..."
  bash "$HOME/.tmux/plugins/tpm/bin/install_plugins" || true
else
  echo "[!] No encontré el binario de TPM install_plugins"
fi

# --- NvChad (solo si NO tienes ya ~/.config/nvim del repo) ----------------
if [ ! -d "$HOME/.config/nvim" ]; then
  echo "[*] No existe ~/.config/nvim. Instalando NvChad..."
  git clone --depth 1 https://github.com/NvChad/NvChad "$HOME/.config/nvim"
  # Puedes añadir tu layer custom después si usas lua/custom
else
  echo "[=] ~/.config/nvim ya existe (saltando instalación de NvChad)"
fi

# --- fzf key-bindings & completion ----------------------------------------
if is_cmd fzf; then
  if [ -d "$HOME/.fzf" ] && [ -x "$HOME/.fzf/install" ]; then
    echo "[*] Configurando fzf (script ~/.fzf/install)..."
    yes | "$HOME/.fzf/install" --key-bindings --completion --no-update-rc
  else
    # vía Homebrew
    if is_cmd brew; then
      FZF_PREFIX="$(brew --prefix 2>/dev/null)/opt/fzf"
      if [ -x "$FZF_PREFIX/install" ]; then
        echo "[*] Configurando fzf (brew script)..."
        yes | "$FZF_PREFIX/install" --key-bindings --completion --no-update-rc
      fi
    fi
  fi
else
  echo "[!] fzf no está instalado; omitiendo keybindings"
fi

# --- starship init (por si falta en zshrc) --------------------------------
if is_cmd starship && ! grep -q 'starship init zsh' "$HOME/.zshrc" 2>/dev/null; then
  echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

# --- WSL: abrir URLs desde terminal (wslview) ------------------------------
if is_cmd wslview && ! grep -q 'BROWSER=wslview' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export BROWSER=wslview' >> "$HOME/.zshrc"
fi

# --- Verificaciones rápidas -----------------------------------------------
echo
echo "[*] Versiones:"
for c in zsh tmux nvim yazi lazygit fzf rg tree delta clang clangd cmake ninja gdb starship; do
  if is_cmd "$c"; then
    printf "  - %-8s " "$c"
    "$c" --version 2>/dev/null | head -n1 || true
  fi
done

echo
echo "[✓] post-install completado. Abre una nueva terminal o ejecuta: source ~/.zshrc"

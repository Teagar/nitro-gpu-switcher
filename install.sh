#!/usr/bin/env bash
set -Eeuo pipefail

SOURCE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
BIN_DIR="$HOME/.local/bin"
APP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}/nitro-gpu-switcher"
INSTALL_BACKUPS="$STATE_HOME/install-backups"

mkdir -p "$BIN_DIR" "$APP_DIR" "$INSTALL_BACKUPS"
chmod +x "$SOURCE_DIR/nitro-gpu" "$SOURCE_DIR/nitro-run" "$SOURCE_DIR/nitro-launcher"

install_link() {
  local name="$1" source="$2" target backup
  target="$BIN_DIR/$name"
  backup="$INSTALL_BACKUPS/bin-$name"
  if [[ -e "$target" && ! -L "$target" && ! -e "$backup" ]]; then
    cp -a "$target" "$backup"
  elif [[ -L "$target" && "$(realpath "$target")" != "$source" && ! -e "$backup" ]]; then
    cp -aL "$target" "$backup"
  fi
  ln -sfn "$source" "$target"
}

install_desktop_override() {
  local name="$1" system_file="$2" command="$3"
  local target backup
  target="$APP_DIR/$name"
  backup="$INSTALL_BACKUPS/$name"
  [[ -f "$system_file" ]] || return 0
  if [[ -f "$target" ]] && ! grep -q '^X-Nitro-GPU-Switcher=true$' "$target" && [[ ! -f "$backup" ]]; then
    cp -a "$target" "$backup"
  fi
  python3 - "$system_file" "$target" "$command" <<'PY'
import pathlib, re, sys
source, target, command = map(pathlib.Path, sys.argv[1:])
text = source.read_text()
text = re.sub(r'(?m)^Exec=(?:/usr/bin/)?(?:steam|heroic)(?=\s|$)', f'Exec={command}', text)
text = text.rstrip() + "\nX-Nitro-GPU-Switcher=true\n"
target.write_text(text)
PY
}

install_link nitro-gpu "$SOURCE_DIR/nitro-gpu"
install_link nitro-run "$SOURCE_DIR/nitro-run"
install_link steam "$SOURCE_DIR/nitro-launcher"
install_link heroic "$SOURCE_DIR/nitro-launcher"

install_desktop_override steam.desktop /usr/share/applications/steam.desktop "$BIN_DIR/steam"
install_desktop_override com.heroicgameslauncher.hgl.desktop /usr/share/applications/com.heroicgameslauncher.hgl.desktop "$BIN_DIR/heroic"
command -v update-desktop-database >/dev/null && update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true

printf '\033[38;5;84m✓\033[0m Nitro GPU Switcher instalado\n'
printf '  Menu:     \033[1mnitro-gpu\033[0m\n'
printf '  GPU avulsa: \033[1mnitro-run <programa>\033[0m\n'
printf '  Steam e Heroic agora seguem automaticamente o perfil ativo.\n'

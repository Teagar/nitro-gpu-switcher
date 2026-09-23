#!/usr/bin/env bash
set -Eeuo pipefail

SOURCE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
TARGET_DIR="${HOME}/.local/bin"
TARGET="$TARGET_DIR/nitro-gpu"

mkdir -p "$TARGET_DIR"
ln -sfn "$SOURCE_DIR/nitro-gpu" "$TARGET"
chmod +x "$SOURCE_DIR/nitro-gpu"

printf '\033[38;5;84m✓\033[0m Instalado em %s\n' "$TARGET"
printf 'Execute: \033[1mnitro-gpu\033[0m\n'

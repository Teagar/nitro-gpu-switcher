# ⚡ Nitro GPU Switcher

Um seletor de perfis de GPU elegante e seguro para notebooks Acer Nitro com **Intel + NVIDIA**, usando **Niri/Wayland** e **Heroic Games Launcher**.

```text
╭──────────────────────────────────────────╮
│          NITRO  GPU  SWITCHER            │
│       Intel  ◉──────◉  NVIDIA            │
╰──────────────────────────────────────────╯
```

## Perfis

| Perfil | Niri e desktop | GTA V no Heroic | Uso indicado |
|---|---|---|---|
| **100% NVIDIA** | NVIDIA | NVIDIA | Compatibilidade máxima, maior uso de VRAM |
| **100% Intel** | Intel | Intel | Economia de energia e diagnóstico |
| **Híbrido recomendado** | Intel | NVIDIA | Mais VRAM disponível para o jogo |

No perfil híbrido, o painel e o compositor ficam na Intel enquanto o GTA V continua usando a GTX por PRIME Render Offload. Captura PipeWire e codificação Intel VAAPI/QSV continuam disponíveis.

## Recursos

- Menu interativo colorido.
- Interface por linha de comando.
- Detecção das GPUs pelos IDs PCI dos fabricantes.
- Caminhos DRM estáveis em `/dev/dri/by-path`.
- Configuração do dispositivo de renderização do Niri.
- Ajuste das variáveis globais NVIDIA.
- Seleção da GPU do GTA V no Heroic.
- Backups automáticos antes de cada alteração.
- Validação da configuração do Niri.
- Não encerra sua sessão automaticamente.

## Instalação

```bash
git clone https://github.com/Teagar/nitro-gpu-switcher.git ~/scripts/nitro-gpu-switcher
cd ~/scripts/nitro-gpu-switcher
./install.sh
```

Depois execute:

```bash
nitro-gpu
```

## Uso direto

```bash
nitro-gpu status
nitro-gpu nvidia
nitro-gpu intel
nitro-gpu hybrid
```

Após trocar o perfil, encerre e entre novamente na sessão. O script nunca força logout.

## Arquivos administrados

- `~/.config/niri/config/debug.kdl`
- `~/.config/niri/config/environment.kdl`
- `~/.config/heroic/GamesConfig/9d2d0eb64d5c44529cece33fe2a46482.json`
- `/etc/environment`

Os backups ficam em:

```text
~/.local/state/nitro-gpu-switcher/backups/
```

## Requisitos

- Bash 5+
- Python 3
- Niri com configuração modular equivalente à documentada acima
- Heroic Games Launcher
- `sudo` para editar `/etc/environment`
- Em Arch Linux, `vulkan-intel` e `lib32-vulkan-intel` para o perfil Intel

O script oferece instalar os drivers Vulkan Intel quando necessário.

## Personalização

É possível substituir caminhos e o ID do jogo por variáveis:

```bash
INTEL_RENDER=/dev/dri/renderD129 \
NVIDIA_RENDER=/dev/dri/renderD128 \
GTA_APP_ID=seu-app-id \
HEROIC_GTA_CONFIG=/caminho/config.json \
nitro-gpu hybrid
```

## Aviso

O projeto foi criado para uma configuração específica de Niri modular e deve ser revisado antes de uso em outras distribuições. Alterações de perfil só entram integralmente em vigor após uma nova sessão.

## Licença

[MIT](LICENSE)

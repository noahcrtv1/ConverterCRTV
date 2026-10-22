#!/bin/zsh
# Baixa ffmpeg + ffprobe estáticos (Apple Silicon, build de Martin Riedl, GPL) para vendor/bin.
set -euo pipefail
cd "$(dirname "$0")/.."
DL=vendor/downloads BIN=vendor/bin
mkdir -p "$DL" "$BIN" vendor/licenses
for tool in ffmpeg ffprobe; do
  url=$(curl -fsL -r 0-0 -o /dev/null -w '%{url_effective}' "https://ffmpeg.martin-riedl.de/redirect/latest/macos/arm64/release/$tool.zip")
  curl -fL --progress-bar -o "$DL/$tool.zip" "$url"
  expected=$(curl -fsL "$url.sha256" | awk '{print $1}')
  actual=$(shasum -a 256 "$DL/$tool.zip" | awk '{print $1}')
  [[ "$expected" == "$actual" ]] || { echo "Checksum do $tool não confere"; exit 1; }
  unzip -oq "$DL/$tool.zip" -d "$DL/$tool" && install -m 755 "$DL/$tool/$tool" "$BIN/$tool"
done
curl -fsL -o vendor/licenses/ffmpeg-GPL-3.0.txt https://www.gnu.org/licenses/gpl-3.0.txt
xattr -cr "$BIN"
"$BIN/ffmpeg" -version | head -1

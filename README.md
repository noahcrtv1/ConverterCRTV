# ConverterCRTV

App nativo macOS (SwiftUI + Liquid Glass) que converte vídeos para abrirem no **Adobe Premiere** com imagem e som. Resolve o clássico "arrastei o vídeo e só veio o áudio" — típico de arquivos VP9/AV1 do YouTube, WebM, MKV e HEVC 10-bit. Motor: `ffmpeg`.

## Baixar (jeito fácil)

Baixe o `.dmg` em **[Releases](https://github.com/noahcrtv1/ConverterCRTV/releases/latest)**, abra e arraste o ConverterCRTV para Aplicativos.
Na primeira abertura, se o macOS bloquear: **Ajustes do Sistema ▸ Privacidade e Segurança ▸ Abrir Mesmo Assim**.

## Como usar

- Arraste vídeos ou pastas para a janela (ou para o ícone no Dock).
- Ou no Finder: selecione os arquivos ▸ botão direito ▸ **Ações Rápidas / Serviços ▸ Converter p/ Premiere**.
  Se não aparecer, ative em **Ajustes do Sistema ▸ Teclado ▸ Atalhos de Teclado ▸ Serviços**.

O original nunca é alterado: a conversão sai ao lado dele como `nome (Premiere).mp4`, ou na pasta escolhida no rodapé.

### Presets

| Preset | O que faz |
|---|---|
| **Premiere** | Analisa cada arquivo com `ffprobe` e faz só o necessário: já compatível ▸ ignora; H.264 em MKV/WebM ▸ troca o container (instantâneo, sem perda); áudio Opus/Vorbis ▸ converte só o áudio para AAC; VP9, AV1, HEVC 10-bit ▸ H.264 (x264 veryfast, CRF 18) + AAC. |
| **ProRes 422** | MOV para edição pesada sem travar (VideoToolbox, com fallback em software). |
| **Só áudio** | WAV sem perdas. |

## Compilar no seu Mac

Precisa de um Mac com Apple Silicon (M1 ou mais novo), macOS 26+ e o **Xcode** instalado (abra uma vez e aceite a licença).

```bash
git clone https://github.com/noahcrtv1/ConverterCRTV.git
cd ConverterCRTV
scripts/fetch-tools.sh          # baixa ffmpeg e ffprobe estáticos (com checksum)
scripts/build-app.sh --install  # compila e instala em /Applications
scripts/make-dmg.sh             # opcional: gera build/ConverterCRTV-<versão>.dmg
```

## Licença

MIT. O app embute FFmpeg (GPL v3, build estático de Martin Riedl) — veja `scripts/THIRD-PARTY.txt`.

Faz parte da família CRTV: [DownloaderCRTV](https://github.com/noahcrtv1/DownloaderCRTV) · [SplitterCRTV](https://github.com/noahcrtv1/SplitterCRTV) · [CleanerCRTV](https://github.com/noahcrtv1/CleanerCRTV) · [PDFCRTV](https://github.com/noahcrtv1/PDFCRTV) · [CobrancaCRTV](https://github.com/noahcrtv1/CobrancaCRTV)

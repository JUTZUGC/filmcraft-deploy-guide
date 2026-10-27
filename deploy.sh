#!/usr/bin/env bash
set -euo pipefail
# FilmCraft 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/storytold/filmcraft#downloads
# 更新日期：2026-10-27
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

if [ "$(uname -s)" = "Darwin" ]; then url=https://github.com/storytold/filmcraft/releases/download/v0.13.0/filmcraft-0.13.0-macos-universal.dmg ; want=1313efde320c25361c1bd015c47d18cc4ad40c9215e1eabf2a8ec5db6a7396ed ; file=FilmCraft.dmg ; else url=https://github.com/storytold/filmcraft/releases/download/v0.13.0/filmcraft-0.13.0-linux-x86_64.AppImage ; want=d2e604faa0546864485741703a2879c6ba2c55cc7f5cc4ba7d7dac1443a1a6ee ; file=FilmCraft.AppImage ; fi
curl -fL -o "$file" "$url"
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$file" = "FilmCraft.AppImage" ]; then chmod +x FilmCraft.AppImage ; echo "已就绪：./FilmCraft.AppImage" ; else echo "已下载 FilmCraft.dmg，双击挂载后拖进 Applications" ; fi

echo ""

echo "部署完成：打开 FilmCraft，新建项目并导入素材；导出前先确认编解码器与目标平台"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/storytold/filmcraft#downloads"

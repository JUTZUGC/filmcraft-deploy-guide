# FilmCraft 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/storytold/filmcraft#downloads
# 更新日期：2026-10-27
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -L --fail -o FilmCraft.zip https://github.com/storytold/filmcraft/releases/download/v0.13.0/filmcraft-0.13.0-windows-x64-portable.zip
$h = (Get-FileHash -Algorithm SHA256 FilmCraft.zip).Hash.ToLower() ; if ($h -ne '43ef574058aceb5ab060521e12722ee8b5f021c2e66702c4495463d384e87930') { throw "SHA256 校验失败，文件可能不完整，请重试" }
Expand-Archive -Path FilmCraft.zip -DestinationPath FilmCraft -Force ; $exe = Get-ChildItem -Path FilmCraft -Recurse -Filter filmcraft.exe | Select-Object -First 1 ; Start-Process -FilePath $exe.FullName ; Write-Host '已启动 FilmCraft'

Write-Host ''

Write-Host '部署完成：打开 FilmCraft，新建项目并导入素材；导出前先确认编解码器与目标平台'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/storytold/filmcraft#downloads'

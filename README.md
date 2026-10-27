# FilmCraft 一键部署指南

> 第三方部署指南 · 非 FilmCraft 官方仓库。官方项目：[storytold/filmcraft](https://github.com/storytold/filmcraft)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/storytold/filmcraft#downloads)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不想为剪个片子装一整套 Adobe，让百度搭子把 FilmCraft 下好，打开就能剪。

⚠️ 项目 2026-09-30 才开源，版本 0.13.0。内置自己的 H.264 / HEVC / ProRes / AAC 实现，不依赖 FFmpeg；首次导入大素材需要预留磁盘与内存。Windows 有 MSI 与便携版，macOS 是 universal dmg，Linux 有多种包。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/filmcraft-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统下载 FilmCraft、核对 SHA256；Windows 解压后直接启动，Linux 加执行权限，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## FilmCraft 是什么？

FilmCraft 是开源的纯 Rust 写的非线性视频剪辑器，自带编解码器（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/storytold/filmcraft?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

专业向非线性剪辑：双监视器、多轨时间线、素材箱、色彩、特效、音频工作区；编解码器用 Rust 按公开规范自研，GPU 合成在线性光下完成，时间计算用整数帧。

- 时间线：多轨、嵌套、波纹删除、吸附、无限撤销
- 编码：H.264 / HEVC / ProRes / AAC 自研，导出不依赖 FFmpeg
- 音频：EQ、动态、限幅、降噪、响度表对齐 EBU R128
- 字幕：SRT / WebVTT / SCC，可烧录进导出
- 色彩：线性光 GPU 合成，波形图与矢量示波器
- Agent：界面操作背后都是命令，可被自动化驱动

（来源：[官方仓库](https://github.com/storytold/filmcraft)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 16.4k stars | 开源不到一个月，单月新增约 1.6 万 |
| 自研编解码 | 导出不依赖 FFmpeg，格式链完整 |
| 专业时间线 | 多轨、嵌套、波纹删除、无限撤销 |
| 音频完整 | EQ、动态、降噪、响度表齐全 |
| 全平台 | Windows / macOS / Linux / FreeBSD |

| 需要注意 | 说明 |
|---|---|
| 项目很新 | 0.13.0，长工程稳定性待验证 |
| 吃资源 | 4K 素材对内存与磁盘要求高 |
| 学习成本 | 专业 NLE 面板较多 |
| 生态少 | 第三方插件与模板几乎没有 |
| 包体较大 | Windows 便携包约 96 MB |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
if [ "$(uname -s)" = "Darwin" ]; then url=https://github.com/storytold/filmcraft/releases/download/v0.13.0/filmcraft-0.13.0-macos-universal.dmg ; want=1313efde320c25361c1bd015c47d18cc4ad40c9215e1eabf2a8ec5db6a7396ed ; file=FilmCraft.dmg ; else url=https://github.com/storytold/filmcraft/releases/download/v0.13.0/filmcraft-0.13.0-linux-x86_64.AppImage ; want=d2e604faa0546864485741703a2879c6ba2c55cc7f5cc4ba7d7dac1443a1a6ee ; file=FilmCraft.AppImage ; fi
curl -fL -o "$file" "$url"
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$file" = "FilmCraft.AppImage" ]; then chmod +x FilmCraft.AppImage ; echo "已就绪：./FilmCraft.AppImage" ; else echo "已下载 FilmCraft.dmg，双击挂载后拖进 Applications" ; fi
```

安装包来源：[https://github.com/storytold/filmcraft#downloads](https://github.com/storytold/filmcraft#downloads)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v0.13.0 的 Windows 便携包已下载，SHA256 与 Release 记录一致（95.8 MB） | 已验证 2026-10-27 |
| Windows / macOS / Linux 产物与 SHA256 digest 已核对 | 已核对 2026-10-27 |
| 未启动 GUI（本机只做下载校验） | 已核对 2026-10-27 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-27 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

FilmCraft 本身不是 MCP server；它把界面操作暴露成命令，便于 Agent 精确驱动。本仓库的 MCP 只提供下载、校验与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\filmcraft-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

| 平台 | 包 | 用法 |
|---|---|---|
| Windows x64 | `filmcraft-0.13.0-windows-x64-portable.zip` | 解压后双击 exe |
| Windows x64 | `filmcraft-0.13.0-windows-x64.msi` | 双击安装 |
| macOS | `filmcraft-0.13.0-macos-universal.dmg` | 挂载后拖进 Applications |
| Linux | `filmcraft-0.13.0-linux-x86_64.AppImage` | `chmod +x` 后运行 |
| Linux（deb / rpm / Flatpak） | 对应包 | 用系统包管理器安装 |

### 第一次剪辑

1. 新建项目，设置帧率与分辨率
2. 把素材拖进素材箱，再拖到时间线
3. 用 `⌘K` / `Ctrl+K` 在播放头处切开
4. 导出时选平台预设，注意码率与色彩空间

### 导出与字幕

- 视频：H.264 / HEVC / ProRes（422 HQ）
- 音频：AAC / Opus
- 字幕：SRT / WebVTT / SCC，可直接烧录

> ⚠️ 项目很新（0.13.0），复杂工程与长素材可能出问题；重要项目先小段验证，并保留原始素材。

## 常见坑

- 导入卡顿：先用代理素材或降低预览分辨率
- 导出失败：检查磁盘空间与输出编码设置
- 音画不同步：确认项目帧率与素材帧率一致
- 字幕时间偏：按帧核对，别用秒估算
- Windows 选错包：普通 64 位用 x64，ARM PC 用 arm64
- Linux AppImage 打不开：先 `chmod +x`，缺 FUSE 加 `--appimage-extract-and-run`
- 新版本工程不兼容：升级前备份项目文件

## 免责声明

本仓库为第三方指南，与 FilmCraft 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/storytold/filmcraft#downloads)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。

# Research Skills Bundle

这是为 Codex/ChatGPT 整理的科研 Skills 仓库。仓库中的 `research-skills` 插件覆盖选题、检索、综述、研究统筹、统计、绘图、写作、润色、审稿回复、数据声明和论文汇报。

## 已收录

- `scientific-brainstorming`
- `nature-academic-search`
- `literature-review`
- `academic-research-suite`
- `statistical-analysis`
- `scientific-visualization`
- `nature-figure`
- `nature-writing`
- `nature-polishing`
- `nature-reviewer`
- `nature-response`
- `nature-data`
- `nature-paper2ppt`
- `nature-shared`（Nature Skills 的内部共享依赖，不单独调用）

## Windows：安装到个人 Skills 目录

在 PowerShell 中进入本仓库，然后执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\install-skills.ps1
```

脚本只复制尚未存在的 Skill；如果目标目录已有同名文件夹，会跳过而不会覆盖。完成后重启 Codex，或开始一个新对话。

## 作为仓库插件安装

在仓库根目录执行：

```powershell
codex plugin marketplace add .
codex plugin add research-skills@research-skills-marketplace
```

随后新建对话。也可以在 Codex 桌面应用的插件页面中找到 `Research Skills` 并安装。

## 使用示例

```text
$scientific-brainstorming 帮我评估 BFRP-砂浆界面长期退化的选题价值。
$nature-academic-search 检索近五年海床冲刷与桩基周围流固耦合研究。
$literature-review 根据这些论文生成有证据约束的文献综述。
$nature-paper2ppt 把这篇论文制作成中文组会汇报。
```

来源版本与许可证见 [SOURCES.md](SOURCES.md) 和 `THIRD_PARTY_LICENSES/`。第三方 Skills 可能需要额外 Python 包、外部数据库、MCP 或 API 凭据；安装文件本身不自动授予这些外部访问权限。

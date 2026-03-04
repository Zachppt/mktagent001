# 🤖 web3-mkt-agents

> 专为 Web3 项目打造的模块化 AI 营销系统，基于 OpenClaw 构建。
> Fork → 填写 RAG → 部署。从 4 个 Agent 开始，随时扩展到 9 个。

[English](README.md) | **中文**

---

## 这是什么

一套专业的 AI Agent 框架，覆盖 Web3 项目的全部营销和运营职能。每个 Agent 负责一个特定模块，使用最高性价比的模型，通过 PM Agent 协调运转。

**v0.1.0 包含 9 个 Agent：**

| Agent | 职能 | 模型 | 估算月费 |
|-------|------|------|---------|
| 🧠 PM | 任务路由、监控所有 Agent、周报生成 | Claude Sonnet 4.6 | $9–19 |
| 📣 Social | Twitter/X、LinkedIn、表情包、趋势监控 | MiniMax M2.5 | $1–2 |
| ✍️ Content | 博客、视频脚本、设计 Brief | Claude Sonnet 4.6 | $6–12 |
| 📊 Data | 代币价格、竞品监控、SEO、数据分析 | GPT-4.1 Nano | $2–3 |
| 🤝 BD | 目标客户搜索、冷邮件起草、提案 | GPT-4.1 | $4–7 |
| 💬 Community | Discord/TG 情绪监控、FAQ 回复、危机处理 | GPT-4o-mini | $2–4 |
| 🌐 Eco | 生态合作伙伴开拓、活动公告 | MiniMax M2.5 | $1–3 |
| 💰 Finance | 发票记录、预算跟踪、支出分析 | Claude Sonnet 4.6 | $3–6 |
| 🛡️ Security | 仿冒账号扫描、钓鱼检测、API 审计 | Gemini Flash Lite | $1–2 |
| | | **合计** | **~$29–58/月** |

对比全部使用 Claude Opus：~$400+/月

---

## 安装

### 方式 A — 直接粘贴给 OpenClaw Agent（最简单）
在任意 OpenClaw 对话中发送：
```
Install this skill: https://github.com/NanRen01/mktagent3
```

### 方式 B — 只安装部分 Agent
```
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/pm
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/social
```
其余 Agent 同理，路径替换为对应名称即可。

### 方式 C — VPS 自托管
```bash
git clone https://github.com/NanRen01/mktagent3.git
cd mktagent3
bash scripts/deploy.sh
```

---

## 快速上手（3 步）

### 第 1 步：填写 RAG 模板（约 30 分钟）

RAG 文件是每个 Agent 的"知识库"——你的品牌声音、KPI 目标、告警阈值等。
不填 RAG，Agent 就会使用通用模板，无法针对你的项目工作。

**优先填写这 3 个（必须）：**

| 文件 | 作用 | 影响的 Agent |
|------|------|-------------|
| `rag-templates/brand-voice.md` | 品牌语调、禁用词、核心信息 | Social、Content、Eco、Community |
| `rag-templates/kpi-targets.md` | 每周 KPI 目标 | PM、Data |
| `rag-templates/alert-thresholds.md` | 代币价格/成交量告警阈值 | Data |

**填写方式一（推荐）：Dashboard RAG 编辑器**
1. 打开 `dashboard/index.html`
2. 切换到「📝 RAG 编辑器」标签页
3. 选择文件 → 替换 `[占位符]` 内容 → 点击「保存」

**填写方式二：直接编辑文件**
```bash
nano rag-templates/brand-voice.md
nano rag-templates/kpi-targets.md
nano rag-templates/alert-thresholds.md
```

填写完成后同步到 Agent 工作区：
```bash
bash scripts/copy-rag.sh
```

### 第 2 步：配置 API Token

打开 `dashboard/index.html`，填写所有 API Token，然后：
```bash
# 下载 .env 文件，上传到 VPS
scp .env 你的用户名@VPS_IP:~/.openclaw/.env
```

### 第 3 步：部署
```bash
bash scripts/deploy.sh
```

---

## Dashboard 使用

`dashboard/index.html` 是一个纯本地 HTML 文件，双击即可在浏览器打开，无需安装任何东西。

| 标签页 | 功能 |
|--------|------|
| 📋 Status | 配置进度、缺失 Token 提醒、部署命令 |
| 🤖 Agents | 启用/禁用 Agent，实时显示预计费用 |
| 🔑 Model APIs | 填写 Anthropic、OpenAI、MiniMax、Gemini 密钥 |
| 🔌 Integrations | Slack、Telegram、Notion、Twitter/X 等 |
| 📝 RAG 编辑器 | 编辑全部 RAG 文件，保存到 VPS |
| 📤 Export | 导出 `.env` 文件 |

### 通过 VPS 远程访问 Dashboard

**第 1 步：在 VPS 上启动服务**
```bash
cd ~/mktagent3
python3 dashboard/server.py --port 8765 --token 你的密码
```

**第 2 步：本地建立 SSH 隧道**
```bash
ssh -L 8765:localhost:8765 你的用户名@VPS_IP
```

**第 3 步：浏览器打开**
```
http://localhost:8765
```

**第 4 步：在 RAG 编辑器里连接**
- Server URL：`http://localhost:8765`
- Token：你设置的密码
- 点击「Connect VPS」→ 编辑文件 → 点「Save」直接写入服务器

---

## 系统架构

```
你
 └─▶ PM Agent（Claude Sonnet 4.6）
       │
       ├─▶ Social Agent     发推 / 表情包 / 趋势监控
       ├─▶ Content Agent    博客 / 视频 / 设计 Brief
       ├─▶ Data Agent       代币 / 竞品 / SEO ──▶ 反馈循环
       ├─▶ BD Agent         潜在客户 / 冷邮件 / 提案
       ├─▶ Community Agent  情绪监控 / FAQ / 危机草稿
       ├─▶ Eco Agent        活动公告 / 生态合作
       ├─▶ Finance Agent    发票 / 预算 / 支出报告
       └─▶ Security Agent   仿冒 / 钓鱼 / API 审计
```

**三级审批机制：**
- 🟢 **AUTO** — 监控、路由、内部数据读取
- 🟡 **SLACK_REVIEW** — 内容草稿、公告、报告 → 发到 Slack #approvals 频道等待人工确认
- 🔴 **HUMAN_REQUIRED** — 所有对外发送、财务操作、危机响应 → 直接 DM 操作员

**周一自动化序列（09:00 UTC+8）：**
```
08:00  Data Agent      → 社交数据统计 + SEO 报告
08:00  BD Agent        → 潜在客户搜索 + 活动侦察
08:00  Security Agent  → 周度安全摘要
09:00  PM Agent        → 聚合所有输出 → 生成周报
09:00  Content Agent   → 读取 Data Agent 数据 → 优化内容策略
```

---

## RAG 文件完整列表

| 文件 | 优先级 | 影响的 Agent |
|------|--------|-------------|
| `brand-voice.md` | 🔴 必填 | Social、Content、Eco、Community |
| `kpi-targets.md` | 🔴 必填 | PM、Data |
| `alert-thresholds.md` | 🔴 必填 | Data |
| `routing-rules.md` | 🔴 必填 | PM |
| `agent-registry.md` | 🔴 必填 | PM |
| `crisis-sop.md` | 🟡 重要 | PM、Community |
| `competitor-intel.md` | 🟡 重要 | Data |
| `seo-keywords.md` | 🟡 重要 | Data |
| `community-faq.md` | 🟡 重要 | Community |
| `bd-icp.md` | 🟡 重要 | BD |
| `security-impersonation-keywords.md` | 🟡 重要 | Security |
| `finance-budget-plan.md` | 🟡 重要 | Finance |
| 其余 8 个文件 | 🟢 可选 | 各 Agent |

---

## 添加新 Agent

1. `cp -r agents/_TEMPLATE agents/你的-agent`
2. 填写 `AGENTS.md`、`SOUL.md`、`HEARTBEAT.md`、`TOOLS.md`
3. 添加 `skills/你的-agent/SKILL.md`
4. 在 `config/openclaw.json.template` 注册
5. 提交 PR

完整指南：[docs/ADD_AGENT.md](docs/ADD_AGENT.md)

---

## 系统要求

- [OpenClaw](https://openclaw.ai) 已安装并运行
- 对应模型的 API 密钥（详见 `config/openclaw.json.template`）
- Notion 工作空间（任务管理和日志）
- Slack 工作空间（审批和告警）
- Twitter/X 开发者账号（Basic 级别以上）
- VPS 上 Python 3.8+（用于运行 `dashboard/server.py`）

---

## 安全说明

- `deploy.sh` 不使用 `source .env`，防止 shell 注入
- `server.py` 默认绑定 `127.0.0.1`，不暴露到公网
- 所有 RAG 文件读写使用严格白名单校验
- API 请求有频率限制（60次/分钟/IP）
- `.env` 和 `openclaw.json` 已加入 `.gitignore`，不会被 commit

---

## 目录结构

```
mktagent3/
├── SKILL.md                          ← 根 skill pack（GitHub 安装入口）
├── README.md                         ← 英文文档
├── README.zh.md                      ← 中文文档（本文件）
├── agents/
│   ├── _TEMPLATE/                    ← 新 Agent 蓝图
│   ├── pm/ social/ content/ data/    ← 核心 4 个 Agent
│   ├── bd/ community/ eco/           ← 运营 Agent
│   └── finance/ security/            ← 支持 Agent
│       （每个目录：AGENTS.md, SOUL.md, HEARTBEAT.md, TOOLS.md, SKILL.md, memory/, rag/）
├── skills/                           ← 可独立安装的 skill 包
├── rag-templates/                    ← 填写你的项目数据（25 个文件）
├── config/
│   └── openclaw.json.template        ← 所有密钥模板（{{PLACEHOLDER}} 格式）
├── scripts/
│   ├── deploy.sh                     ← 首次 VPS 部署
│   ├── update.sh                     ← 拉取最新代码 + 热重载
│   └── copy-rag.sh                   ← 将 RAG 文件同步到各工作区
├── dashboard/
│   ├── index.html                    ← 配置 Dashboard（浏览器直接打开）
│   └── server.py                     ← VPS 服务端（远程 RAG 编辑）
└── docs/
    ├── ADD_AGENT.md
    └── ROADMAP.md
```

---

## License

MIT — 随意 Fork、修改、基于此构建。

---

## 贡献

欢迎提 PR。请先阅读 [docs/ADD_AGENT.md](docs/ADD_AGENT.md)。
Bug 报告、功能建议、新 Agent 提案，请开 Issue。

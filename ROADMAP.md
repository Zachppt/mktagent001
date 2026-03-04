# Product Roadmap

> 这份路线图基于完整的系统设计讨论，按"先跑通业务逻辑，再优化架构，最后企业级扩展"的顺序排列。
> 每个阶段都有独立价值，可以在任意阶段停下来使用。

---

## 现状：v0.2.0 ✅

**已完成的核心框架**

- 9 个 Agent 完整定义（AGENTS / SOUL / HEARTBEAT / TOOLS / SKILL）
- 32 个 RAG 模板文件，覆盖所有 Agent 的知识库需求
- 安全加固版 `server.py`（allowlist 路径校验 + 速率限制）
- 安全加固版 `deploy.sh`（移除 `source .env`，防 shell 注入）
- Dashboard（本地 + VPS 远程模式，含 RAG 编辑器）
- 中英双语文档 + QUICKSTART 20 分钟上手指南
- 所有 Agent `rag/` 和 `memory/` 目录结构完整

**当前架构**
```
Telegram → OpenClaw → PM Agent → 路由 → 各 Agent → Slack 审批
                         ↓
                    .md 文件 Memory
```

**估算月费：$29–58**

---

## 阶段一：业务逻辑跑通 — v0.3.0

> **目标：让 9 个 Agent 在真实项目里完整跑一个工作周，验证所有路由和审批流程正常。**

这是当前最重要的阶段。架构先不动，专注让每一个函数真正可用。

### 必须完成

**RAG 文件填写**
- 填写 `brand-voice.md`、`kpi-targets.md`、`alert-thresholds.md`（3 个核心文件）
- 填写 `routing-rules.md` 和 `agent-registry.md`（PM Agent 启动必需）
- 其余文件按需填写

**验证每个 Agent 的核心函数**

| Agent | 验证函数 | 验证方式 |
|-------|---------|---------|
| PM | `dispatch_task()` | 发一条 Telegram 消息，确认路由到正确 Agent |
| Social | `post_draft()` | 让它起草一条推文，确认品牌声音正确 |
| Data | `token_monitor()` | 确认价格告警能触发 Slack 消息 |
| Community | `auto_reply()` | 在 Discord/TG 发一个 FAQ 问题，确认自动回复 |
| Security | `impersonation_scan()` | 确认每日扫描报告正常生成 |
| BD | `prospect_search()` | 搜一批目标，确认写入 `bd-pipeline.md` |
| Content | `blog_draft()` | 生成一篇博客草稿，确认品牌合规检查运行 |
| Finance | `invoice_log()` | 上传一张测试发票，确认写入 Notion |
| Eco | `event_announce()` | 生成一条活动公告，确认格式正确 |

**验证审批流程**
- 🟡 SLACK_REVIEW：内容草稿发到 #approvals，人工点 ✅ 后继续
- 🔴 HUMAN_REQUIRED：PM Agent 直接 DM 操作员，不进 #approvals

**验证 PM 的监控**
- 让一个 Agent 故意不响应，确认 PM 能在 30 分钟内发出 Slack 告警

**周一序列完整跑一次**
```
08:00 Data Agent  → 社交数据 + SEO 报告
09:00 PM Agent    → 聚合生成周报
09:00 Content     → 读取 Data 输出优化内容策略
```

### 同步完成

**`scripts/validate.sh`**
部署前自动检查：RAG 文件是否有未填的 `[placeholder]`，所有必填 Token 是否存在。

**`scripts/health-check.sh`**
部署后自动 ping 所有 9 个 Agent，返回状态报告。

**Notion Database 建立**
- Task DB（PM Agent 读写）
- Finance DB（Finance Agent 写入）
- 每日日志 DB（所有 Agent 写入）

---

## 阶段二：Memory 与上下文优化 — v0.4.0

> **目标：解决 memory 文件膨胀问题，引入结构化存储，降低 token 成本。**

跑通业务逻辑之后，你会开始感受到 memory 文件越来越大的问题。这个阶段来解决它。

### Memory 三层架构

把每个 Agent 的 memory 从单文件改成三层：

```
memory/
├── hot.md          ← 最近 48 小时，<200 tokens，每次启动必读
├── warm.md         ← 最近 30 天，压缩摘要，按需读取
└── archive/
    └── YYYY-MM.md  ← 30 天以上，纯归档，不进上下文
```

**触发规则：**
- `hot.md` 超过 800 tokens → 自动降级旧记录到 `warm.md`
- `warm.md` 超过 5000 tokens → 压缩归档到 `archive/`
- 触发压缩的模型：MiniMax M2.5（成本最低的摘要模型）

### YAML Front Matter 元数据

每个 memory 文件头部加结构化元数据：

```yaml
---
agent: data
layer: hot
last_updated: 2026-03-04T08:00Z
token_estimate: 743
entries: 48
---
```

PM Agent 做 `monitor_agents()` 时只读 front matter，不读文件内容。监控成本从"读全文"降到"读 6 行"。

### Notion 作为日志后端

**高频数据（不进 Notion）：**
- 代币价格快照（5 分钟一次）→ 只存 `hot.md`，滚动保留最新 12 条

**低频重要数据（写 Notion）：**
- 告警事件 → 立即写入 Notion Alert DB
- 任务完成记录 → 写入 Notion Task DB
- 每日摘要 → PM Agent 每天 23:59 生成，写入 Notion Daily Log

**Notion Database Schema**

```
Agent Daily Log DB：
  Date        (Date)
  Agent       (Select)
  Function    (Select)
  Summary     (Text, max 200 chars)
  Status      (Select: SUCCESS/FAILED/PENDING)
  Token_Cost  (Number)
  Alert_Level (Select: NONE/NOTABLE/IMMEDIATE)
```

Agent 启动时的上下文加载：
```
读 hot.md（200 tokens，本地）
  ↓ 如需历史
Notion query "last 7 days daily summary"（精确 7 行）
  ↓ 如需特定数据
Notion filter query（返回 3-5 条）
```

**token 成本对比：**
- 改造前：读整个 memory 文件，可能 10,000+ tokens
- 改造后：hot.md 200 tokens + 按需 Notion query 100-300 tokens

### 跨 Agent 上下文包标准化

定义固定格式，PM 路由任务时按此打包，控制总大小在 1000 tokens 以内：

```
TASK_ID: uuid
INTENT: SOCIAL
OPERATOR_INPUT: [原始消息，max 200 tokens]
RELEVANT_MEMORY: [hot.md 相关条目，max 300 tokens]
RELEVANT_RAG: [品牌声音摘要，max 200 tokens]
CONSTRAINTS: [审批级别 + 截止时间，max 100 tokens]
```

---

## 阶段三：稳定性与可观测性 — v0.5.0

> **目标：出问题知道在哪，任务失败不丢失。**

### 死信队列（Dead Letter Queue）

任务失败后不静默消失，进入重试队列：
- 自动重试 3 次，间隔递增（1 分钟、5 分钟、15 分钟）
- 3 次失败后 → Slack 告警 + 写入 Notion Error Log
- 人工处理后可手动重新触发

### 结构化日志

所有 Agent 的操作统一输出结构化日志格式：

```json
{
  "ts": "2026-03-04T09:00:00Z",
  "agent": "social",
  "function": "post_draft",
  "input_tokens": 450,
  "output_tokens": 320,
  "duration_ms": 2840,
  "status": "SUCCESS",
  "approval_tier": "SLACK_REVIEW"
}
```

这为下一阶段的 Grafana 监控提供数据源。

### `scripts/memory-audit.sh`

手动运行，输出每个 Agent 当前 memory 状态：

```
=== Memory Audit ===
pm       hot: 180 tokens  warm: 2,400 tokens  archive: 3 files
social   hot: 340 tokens  warm: 8,100 tokens  ⚠️ warm 接近阈值
data     hot: 95 tokens   warm: 1,200 tokens
...
```

### GitHub Actions CI

每次 PR 自动检查：
- SKILL.md frontmatter 格式是否正确
- RAG 模板是否有未替换的 `{{PLACEHOLDER}}`
- `deploy.sh` 语法检查（shellcheck）

---

## 阶段四：消息总线 + 并行执行 — v1.0.0

> **目标：从串行路由改成并行处理，PM Agent 不再是单点瓶颈。**

这是从"跑通"到"高效"的分水岭。引入真正的消息队列。

### 技术引入：Redis Streams + BullMQ

```
Telegram / Slack / API
        ↓
   Redis Streams（消息总线）
        ↓
┌───────┬───────┬───────┐
Social  Data   BD    Security
Worker Worker Worker  Worker
  ↓       ↓     ↓       ↓
并行执行，互不阻塞
```

PM Agent 的角色变化：
- 之前：接收 → 分类 → 转发 → 等回复 → 汇报（串行）
- 之后：生成任务投入队列（完成），结果由各 Worker 自己上报

**带来的变化：**
- 20 个任务同时进来 → 9 个 Agent 同时处理
- 单个 Agent 超时不影响其他 Agent
- 高峰期可以起多个 Social Worker 实例

### 共享状态层：Redis

把所有 Agent 共用的上下文放进 Redis，不再由 PM 每次打包传递：

```
redis.set("project:brand-voice", 摘要, TTL=24h)
redis.set("project:active-alerts", 当前告警列表, TTL=1h)
redis.set("agent:data:last-scan", 上次扫描结果, TTL=6h)
```

Agent 启动时从 Redis 拉，不从上下文里读。

### 调用分级优化（降本）

在 LLM 调用前加一层判断：

```
输入任务
  ↓
规则引擎（0 token）
  ├─ 命中 FAQ 缓存      → 直接返回，不调用 LLM
  ├─ 重复任务（24h内）  → 返回缓存结果，不调用 LLM
  ├─ 简单路由分类       → Gemini Flash（$0.00001/次）
  └─ 复杂内容生成       → Claude Sonnet（$0.003/次）
```

FAQ 命中率通常 60-70%，这一层直接把 Community Agent 成本砍一半。

### Data Agent 批处理

```
之前：每 5 分钟一次 LLM 调用分析价格
之后：收集 30 分钟快照 → 一次 LLM 调用分析整批
```
调用次数降 83%，且 30 分钟批量分析比单次更容易发现趋势。

---

## 阶段五：可观测性仪表盘 — v1.1.0

> **目标：系统运行状态完全透明，出问题 5 分钟内定位。**

### Prometheus + Grafana

监控面板包含：
- 每个 Agent 的任务吞吐量（条/小时）
- 平均响应时间（毫秒）
- 失败率趋势
- Token 消耗（按 Agent、按模型、按天）
- 待审批任务积压数

### OpenTelemetry 分布式追踪

一个任务的完整链路追踪：
```
Telegram 消息进入 [2ms]
  → PM 分类 [340ms]
  → Social Agent 接收 [12ms]
  → LLM 调用 [2.8s]
  → Slack 审批推送 [45ms]
  → 等待人工审批 [4.2h]
  → 执行发布 [120ms]
```

出问题知道卡在哪一步，延迟在哪里。

---

## 阶段六：企业级扩展 — v2.0.0

> **目标：多项目、多团队、水平扩展。**

### 多项目支持

一套系统管理多个 Web3 项目，每个项目有独立的：
- RAG 文件集（brand-voice、kpi-targets 等）
- Notion workspace
- Telegram/Slack 频道
- Token 用量隔离

```
Router
  ├─ project-a → Agent Pool A（共享 Worker，独立 RAG）
  ├─ project-b → Agent Pool B
  └─ project-c → Agent Pool C
```

### Agent 智能协作（跨 Agent 信号）

目前 Agent 之间只有 PM 中转。这个阶段引入订阅机制：

```
Data Agent 检测到代币价格异动
  → 自动通知 Community Agent（准备 FAQ 回复）
  → 自动通知 Social Agent（暂停计划内容发布）
  → 自动通知 PM Agent（进入 Watch 状态）
```

不需要人工触发，Agent 之间直接响应彼此的信号。

### 容器化部署

```yaml
# docker-compose.yml 示意
services:
  pm-agent:      image: web3-agents/pm
  social-worker: image: web3-agents/social
                 replicas: 2          # 高峰期起 2 个实例
  data-worker:   image: web3-agents/data
  redis:         image: redis:7
  postgres:      image: postgres:16
  grafana:       image: grafana/grafana
```

单机 Docker Compose 跑小项目，K8s 跑多项目企业部署。

---

## 技术栈演进路径

```
v0.2.0（现在）
  OpenClaw + .md 文件 + Notion（手动）

v0.4.0
  OpenClaw + 三层 Memory + Notion（自动写入）

v1.0.0
  OpenClaw + Redis Streams + PostgreSQL + Notion

v2.0.0
  自定义 Worker + Redis + PostgreSQL + Notion + Docker/K8s
```

---

## 成本演进预测

| 阶段 | 月费估算 | 主要优化 |
|------|---------|---------|
| v0.2.0（现在） | $29–58 | 多模型分级 |
| v0.4.0 | $20–40 | Memory 优化减少重复 token |
| v1.0.0 | $12–25 | FAQ 缓存 + Data Agent 批处理 |
| v2.0.0 | $8–15/项目 | 多项目共享 Worker |

---

## 当前最重要的一件事

**填好 5 个核心 RAG 文件，让 PM Agent 跑通第一个完整的任务路由。**

```
brand-voice.md        → 品牌声音
kpi-targets.md        → KPI 目标
alert-thresholds.md   → 代币告警阈值
routing-rules.md      → PM 路由规则
agent-registry.md     → Agent 注册表
```

其他所有优化都建立在"业务逻辑跑通"这个基础上。

---

## Contributing

欢迎提 PR、开 Issue。
新 Agent 提案请先开 Issue 描述职能和目标模型，通过讨论后再实现。
见 [ADD_AGENT.md](ADD_AGENT.md)。

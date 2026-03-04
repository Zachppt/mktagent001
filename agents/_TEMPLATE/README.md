# Agent Template

This folder is the blueprint for every new agent in the framework.

## How to Add a New Agent

1. Copy this entire `_TEMPLATE/` folder:
   ```bash
   cp -r agents/_TEMPLATE agents/YOUR_AGENT_NAME
   ```

2. Fill in each file:
   - `AGENTS.md` — SOP, functions, routing rules
   - `SOUL.md` — personality, tone, identity
   - `HEARTBEAT.md` — scheduled tasks
   - `TOOLS.md` — tool usage notes

3. Replace every `{{PLACEHOLDER}}` with your agent's specifics.

4. Add a corresponding `skills/YOUR_AGENT_NAME/SKILL.md`.

5. Register in `config/openclaw.json.template` under `agents.list`.

See [docs/ADD_AGENT.md](../../docs/ADD_AGENT.md) for detailed instructions.

---
description: 分析草稿提示词并输出优化后的、ECC 增强版本，可直接粘贴运行。不执行任务——仅输出建议性分析。
---

# /prompt-optimize

分析并优化以下提示词以最大化 ECC 利用率。

## 你的任务

对下方用户输入应用 **prompt-optimizer** 技能。遵循 6 阶段分析流程：

0. **Project Detection** — Read CLAUDE.md, detect tech stack from project files (package.json, go.mod, pyproject.toml, etc.)
1. **Intent Detection** — Classify the task type (new feature, bug fix, refactor, research, testing, review, documentation, infrastructure, design)
2. **Scope Assessment** — Evaluate complexity (TRIVIAL / LOW / MEDIUM / HIGH / EPIC), using codebase size as signal if detected
3. **ECC Component Matching** — Map to specific skills, commands, agents, and model tier
4. **Missing Context Detection** — Identify gaps. If 3+ critical items missing, ask the user to clarify before generating
5. **Workflow & Model** — Determine lifecycle position, recommend model tier, and split into multiple prompts if HIGH/EPIC

## Output Requirements

- Present diagnosis, recommended ECC components, and an optimized prompt using the Output Format from the prompt-optimizer skill
- Provide both **Full Version** (detailed) and **Quick Version** (compact, varied by intent type)
- Respond in the same language as the user's input
- The optimized prompt must be complete and ready to copy-paste into a new session
- End with a footer offering adjustment or a clear next step for starting a separate execution request

## CRITICAL

Do NOT execute the user's task. Output ONLY the analysis and optimized prompt.
If the user asks for direct execution, explain that `/prompt-optimize` only produces advisory output and tell them to start a normal task request instead.

Note: `blueprint` is a **skill**, not a slash command. Write "Use the blueprint skill"
instead of presenting it as a `/...` command.

## User Input

$ARGUMENTS

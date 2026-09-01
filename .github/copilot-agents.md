There is no single “best” model — models are optimized for different trade‑offs: quality, speed, code skill, and cost.

# Overview

This document summarizes recommended model families and when to use them for everyday development tasks. Keep cost multipliers and performance trade‑offs in mind when choosing a model.

## Premium vs Standard

- Premium models consume credits (examples: 0.33x, 1x, 3x, 7.5x multipliers).
- Standard models may be included in your plan.
- Multiplier examples:
  - 0.33x = cheap & fast
  - 7.5x = very powerful but expensive

## Auto

Auto selects a model based on the task. It can be convenient but offers the least control and mixed quality.

## Claude (Anthropic) 🔵

Claude models are strong at reasoning, readability, and long-context tasks. They are generally safe and produce structured outputs.

- **Claude Haiku** (e.g. 4.5) — fast & cheap
  - Best for: small tasks, summaries, simple code, quick refactors
  - Strengths: speed, low cost
  - Weaknesses: weaker on complex reasoning
  - Use when: "Explain this file", "Rename variables", "Basic Spring REST controller"

- **Claude Sonnet** (4 / 4.5 / 4.6) — balanced
  - Best for: everyday development, business logic, explanations
  - Strengths: good reasoning and speed
  - Weaknesses: not the top choice for very large design problems
  - Use when: "Add a feature", "Refactor a service", "Explain architecture"

- **Claude Opus** (4.5 / 4.6 / 4.7) — maximum reasoning
  - Best for: complex systems, architecture, deep refactors
  - Strengths: strongest reasoning and multi-step thinking
  - Weaknesses: slower and more expensive
  - Use when: complex domain logic, large-scale refactors, understanding unfamiliar legacy code
  - Avoid for simple CRUD or quick questions

## GPT (OpenAI) 🟢

GPT models are strong generalists for coding, tooling, and reliable results.

- **GPT‑4.1 / GPT‑4o** — stable & reliable (standard)
  - Best for: predictable results, solid coding
  - Strengths: consistency and good reasoning
  - Weaknesses: slightly outperformed by GPT‑5 for code tasks

- **GPT‑5 mini** — standard, lightweight
  - Best for: quick coding help, small edits, conversational tasks
  - Strengths: speed, lower cost
  - Weaknesses: limited reasoning depth
  - Good default if you don't want to think about models

- **GPT‑5.2 / GPT‑5.4** — high-end general intelligence
  - Best for: complex problem solving and advanced refactors
  - Strengths: strong reasoning and code generation
  - Weaknesses: higher cost

- **GPT‑5.x‑Codex** (e.g. GPT‑5.2‑Codex / GPT‑5.3‑Codex) — coding specialists
  - Best for: writing code, refactors, tests, migrations
  - Strengths:
    - Understands repo structure
    - Produces compilable, runnable code
  - Weaknesses: explanations may be less verbose than general GPT
  - Use when: writing Spring Boot features, migrating APIs, generating tests

- **GPT‑5.4 mini** — cheaper GPT‑5 option
  - Best for: light coding with lower cost; trades some quality for speed

## Gemini (Google) 🟡

Gemini models are capable generalists; they are often competitive for analytical tasks and large-context reasoning.

- **Gemini 2.5 Pro**
  - Best for: analytical tasks, explanations, cross-language reasoning
  - Weaknesses: coding quality slightly less consistent than Codex/GPT

- **Gemini 3 Flash** (Preview)
  - Best for: very fast responses
  - Weaknesses: preview quality; less reliable for critical tasks

## Grok Code Fast 🔴

Grok Code Fast is optimized for speed.

- Best for: very fast coding responses
- Strengths: speed
- Weaknesses: lower reasoning depth and consistency
- Use when: speed is more important than correctness
- Avoid for critical production logic

## Quick recommendations (human-friendly)

- Daily work → GPT‑5 mini or Claude Sonnet
- Java / Spring Boot coding → GPT‑5 Codex (recommended)
- Architecture & deep reasoning → Claude Opus
- Fast, cheap help → Claude Haiku

### Avoid common misuses

- Don’t use Opus for trivial edits — it’s overkill and expensive.
- Be cautious with preview models for production-critical tasks.

## Why pick Codex as the primary coding model

Codex models specialize in producing usable, runnable code. If you want a single default for code-heavy work, Codex makes sense.

| Task | Why Codex is ideal |
|------|--------------------|
| Unit tests | Understands test frameworks, mocking patterns, and edge cases |
| README / docs | Produces structured, accurate Markdown and commands |
| Shell scripts | Produces safe, idiomatic Bash for common tasks |
| Kubernetes & Helm | Knows kubectl commands, Helm templates, and values files |
| Solo developer workflows | Produces finished artifacts you can copy → run → commit |

Codex models are specialized for "write usable code", not just explanations. That matters when you want output you can run with minimal iteration.

## Picking a companion

- If you want a cheap, fast companion for small tasks, use Claude Haiku or GPT‑5 mini. Good for renaming variables, quick explanations, documentation tweaks, and simple scripts.

## Summary

- Think → Codex (for heavy coding)
- Cleanup → Haiku / GPT‑5 mini (fast, cheap)
- Architecture reasoning → Claude Opus

This guidance is intended as a practical starting point. Adjust model choice to match the specific task, budget, and required accuracy.

The 4 layers Copilot uses to “learn” your project
Think of it as a stack (top overrides bottom):
┌─────────────────────────────┐
│  Agent (.agent.md)          │   ← role + boundaries
├─────────────────────────────┤
│  Instructions               │   ← rules & standards
├─────────────────────────────┤
│  Repository Content         │   ← your real code
├─────────────────────────────┤
│  Base Model (GPT‑5 mini)    │
└─────────────────────────────┘

Tell the agent what it is (role limit)
This is critical — vague identity = bad results.

Tell the agent what files it should study
This dramatically improves accuracy.

Use real examples from your repo
One real example beats 10 rules.

Add repo-wide standards
If one Helm chart is good, Copilot copies it everywhere.

✅ Agent lives in .github/agents/
✅ Clear identity and scope
✅ References real repo paths
✅ Repo has clean examples
✅ copilot-instructions.md exists
If all five are true → Copilot behaves like a trained teammate.
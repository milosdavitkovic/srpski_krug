# `.github` reference

- Purpose: central entry point for Copilot instructions, agent specs, and workflow metadata in this repository.
- Use this folder to find the authoritative guidance before creating or reviewing code, docs, scripts, or automation.

## Key files

| File | Use |
| --- | --- |
| `copilot-instructions.md` | Repository-wide Copilot rules and coding conventions. |
| `copilot-agents.md` | Model-selection guidance for Copilot tasks. |
| `agents/` | Task-specific agent specs and scope definitions. |
| `workflows/` | GitHub Actions workflow definitions. |

## Agent guidance

- Read the relevant agent spec before editing files in that domain.
- Keep task scope aligned with the agent’s folder and responsibility.
- Prefer the smallest applicable change set and the nearest existing pattern.

## Quick rules

- Do not assume hidden conventions; check the linked instructions first.
- Do not use this folder for feature implementation.
- Keep additions short, explicit, and consistent with the repository style.

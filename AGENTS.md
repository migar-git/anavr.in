---
schema_version: "1.0"
---

# AGENTS.md — Governed Swarm Assignment: anavr.in

> Machine-readable agent assignment file for the ClawMedia Digital agency swarm.
> Authority: Claude Judge (Final Arbiter)
> Generated: 2026-03-29
> Protocol: DISCOVER → PROPOSE → VALIDATE → APPLY → VERIFY → REPEAT

---

## Repo Identity

```yaml
repo: anavr.in
type: static-site
canonical_purpose: Static HTML site â€” Anavrin brand, products/blog/about pages
authority_ceiling: 1
```

---

## Agent Assignments

```yaml
agents:
  systems_architect:
    agent: claude-opus-4-6
    role: Systems Architect
    handles:
      - content_strategy
      - ux_review
    constraints:
      - proposes_only: true
      - never_commits_to_main: true

  repo_executor:
    agent: github-copilot
    role: Repo Executor
    handles:
      - page_update
      - content_addition
      - seo_update
    constraints:
      - feature_branch_only: true
      - requires_judge_approval: true

  build_automation:
    agent: codex
    role: Build & Automation Agent
    handles:
      - build_config
      - deploy_script
    constraints:
      - feature_branch_only: true
      - ci_must_pass: true
      - requires_judge_approval: true

  final_arbiter:
    agent: claude-sonnet-4-6
    role: Final Arbiter (Judge)
    handles:
      - pr_review
      - publish_gate
    constraints:
      - sole_merge_authority: true
      - authority_ceiling: 1
      - human_escalation_on_level: 3
```

---

## Shared Memory Objects

```yaml
memory:
  gap_ledger: dev-analytics/analytics/gap_ledger.jsonl
  decision_log: dev-analytics/analytics/agent_decisions.jsonl
  canonical_truth: dev-analytics/analytics/canonical_truth.json
  repo_entry_key: anavr.in
```

---

## Iteration Protocol

```yaml
iteration:
  loop: [DISCOVER, PROPOSE, VALIDATE, APPLY, VERIFY]
  branch_pattern: "agency/anavr.in/{gap_id}"
  pr_title_pattern: "swarm(anavr.in): {gap_id} — {description}"
  max_retries_before_human_escalation: 3
  ci_required_before_judge_review: true
```

---

## Protected Operations (Human Gate — Level 3)

```yaml
human_required:
  - deploy_to_production
  - merge_to_main
  - secret_rotation
  - cross_repo_structural_change
```

---

## Runbook Reference

Full protocol: `dev-analytics/SWARM_RUNBOOK.md`

---
name: github-pages-publisher
description: Build, verify, commit, and push Markdown textbook website updates for GitHub Pages. Use when Codex needs to publish the generated HTML site, validate index.html and assets, check git status, and trigger an existing GitHub Pages workflow.
---

# GitHub Pages Publisher

## Workflow

1. Inspect existing Pages configuration first. In this repo, `.github/workflows/deploy-pages.yml` builds `index.html`, copies `assets/`, and deploys a `.site` artifact.
2. Read `book.config.yaml` when present. Use `html_build_command`, `pages_required_files`, `pages_git_add_paths`, and `pages_workflow` from that file before falling back to defaults.
3. Run the project HTML build. Prefer the configured command, then `npm run build:html`, then `scripts/build-html.ps1`.
4. Verify required site files exist.
5. Check the current branch, remote, upstream, and `git status --short`.
6. Commit only the configured generated/site-relevant paths, then push the current branch to trigger the Pages workflow.

## Automated Publisher

Use the bundled script from the repo root:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\github-pages-publisher\scripts\Publish-GitHubPages.ps1
```

Verify without committing or pushing:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\github-pages-publisher\scripts\Publish-GitHubPages.ps1 -DryRun
```

Override the commit message when needed:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\github-pages-publisher\scripts\Publish-GitHubPages.ps1 -CommitMessage "Publish textbook site"
```

## Safety

Stop if the build fails, expected assets are missing, the repo is not a git worktree, the remote is missing, or there are no changes to publish. Use `-DryRun` for verification. Do not invent a Pages deployment method when a workflow already exists.

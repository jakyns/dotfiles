# Dotfiles

Personal macOS dotfiles repository that automates development environment setup using Ansible, Homebrew, and Mise (polyglot version manager).

## Bootstrap & Provisioning

```bash
# Full machine setup (first-time or re-provision)
./bootstrap.sh

# Re-run Ansible only (after initial setup)
cd provision && ansible-playbook local.yml -i hosts -K
```

`bootstrap.sh` handles: Xcode CLI tools → Homebrew → Ansible → Ansible playbook → cask updates → cleanup.

## Architecture

```
config/                               # App config symlinked into ~/ (claude, ghostty, nvim, bundle, mise)
provision/
├── local.yml                         # Main Ansible playbook
├── hosts                             # Inventory (localhost)
└── roles/
    ├── packages/                     # Software installation
    │   ├── vars/main.yml             # All package lists (brew, cask, MAS, language packages)
    │   ├── tasks/packages/macos/     # brew.yml, cask.yml, mas.yml
    │   ├── tasks/packages/custom/    # Per-tool: nodejs, python, ruby, elixir, go, zsh, claude, ghostty
    │   └── handlers/main.yml         # Single `update shims` handler runs `mise reshim`
    └── local/                        # Dotfile symlinks & editor setup
        ├── vars/main.yml             # Symlink definitions
        └── tasks/                    # dotfiles.yml, vim.yml, tmux.yml
```

**Two roles:**
- `packages` — installs everything via Homebrew, Cask, Mac App Store, and language-specific tools (managed via Mise)
- `local` — creates symlinks from `~/` to files in this repo, sets up Neovim and Tmux plugins

## Adding/Updating Packages

All package lists live in `provision/roles/packages/vars/main.yml`:
- `brew_packages` — CLI tools
- `cask_packages` — GUI apps
- `mas_packages` — Mac App Store apps (need app ID)
- Language packages: `yarn_packages`, `pip_packages`, `gem_packages`
- `claude_skills` — third-party Claude Code skills, grouped by source repo

Language versions are defined in both `provision/roles/packages/vars/main.yml` and `config/mise/config.toml` — keep them in sync. `config/mise/config.toml` is linked to `~/.config/mise/config.toml` as the global Mise config.

## Adding Dotfiles

1. Add the file to the repo root, or to `config/<app>/` if it lives in an app's config directory
2. Add a symlink entry to `provision/roles/local/vars/main.yml`
3. The `local/tasks/dotfiles.yml` task will create the symlink on next provision

## Claude Code

The `config/claude/` directory holds the Claude Code config that gets symlinked into `~/.claude`: `CLAUDE.md`, `settings.json`, `statusline.sh`, and skills you wrote yourself in `config/claude/skills/`. `RTK.md` is not in the repo: `custom/claude.yml` runs `rtk init -g` to generate it.

Third-party skills are not stored in the repo. The `custom/claude.yml` task installs each entry in `claude_skills` with `npx skills add` and skips skills that already exist in `~/.claude/skills`.

To add a skill:

- From GitHub: add its name under the source repo in `claude_skills`.
- Your own: create `config/claude/skills/<name>/SKILL.md` and add a symlink entry for `~/.claude/skills/<name>` in `provision/roles/local/vars/main.yml`. Link each skill directory on its own, not the whole `~/.claude/skills` directory, because the skills CLI also writes there.

## Version Management

[Mise](https://mise.jdx.dev/) manages Node.js, Python, Ruby, Erlang, and Elixir versions. After installing a new language version via Ansible, the single `update shims` handler runs `mise reshim` to update all shims.

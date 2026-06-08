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
provision/
├── local.yml                         # Main Ansible playbook
├── hosts                             # Inventory (localhost)
└── roles/
    ├── packages/                     # Software installation
    │   ├── vars/main.yml             # All package lists (brew, cask, MAS, language packages)
    │   ├── tasks/packages/macos/     # brew.yml, cask.yml, mas.yml
    │   ├── tasks/packages/custom/    # Per-language: nodejs, python, ruby, elixir, go, kubernetes, zsh
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

Language versions are defined in both `provision/roles/packages/vars/main.yml` and `mise.toml` — keep them in sync.

## Adding Dotfiles

1. Add the file to the repo root
2. Add a symlink entry to `provision/roles/local/vars/main.yml`
3. The `local/tasks/dotfiles.yml` task will create the symlink on next provision

## Version Management

[Mise](https://mise.jdx.dev/) manages Node.js, Python, Ruby, Erlang, and Elixir versions. After installing a new language version via Ansible, the single `update shims` handler runs `mise reshim` to update all shims.

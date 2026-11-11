# hapu's NixOS configuration

Personal NixOS and standalone Home Manager configuration for the `nixos` host
(`x86_64-linux`) and the `hapu` user. This is a host-specific setup, not a generic
installation template.

## What's configured

- **Desktops:** Hyprland and niri, with Noctalia.
- **Shell:** Nushell, with Home Manager-managed shell integrations and completions.
- **Editors:** nixCats Neovim, an alternate nvf Neovim package, Emacs, and Helix.
- **Appearance:** Stylix with the Base16 Stella theme, with per-application overrides.
- **Music:** MPD with PipeWire output.

Both compositor setups and all four editor configurations are intentional.

## Layout

```text
flake.nix                         Inputs and flake-parts outputs
flake.lock                        Pinned dependencies
nixos/
  flake-modules.nix                NixOS configuration entry point
  core/                           Boot, networking, locale, and users
  desktop/                        Display/login setup, audio, and portals
  hardware/                       Hardware settings and generated configuration
  dev/                            System development support
  games/                          Steam configuration
home-manager/
  flake-module.nix                 Standalone Home Manager entry point
  core/                           Home settings and package categories
  shell/                          Nushell and shell-tool modules
    nushell/                      jj and nb completion files
  desktop/                        Compositors, Noctalia, theming, and udiskie
  dev/                            Emacs, Helix, and Git
  media/                          MPD
nixcats/                          Local flake and Lua for the main Neovim package
nvf/                              Alternate Neovim flake module, config, and Lua
```

NixOS, Home Manager, and nvf use `import-tree` within their configured module
subtrees. New `.nix` modules in those scopes are discovered automatically. The
generated hardware configuration is imported explicitly.

## Validate

Run these commands from the repository root. They evaluate the configurations
without building or activating them:

```bash
nix flake check --no-build --no-write-lock-file
nix eval --raw '.#nixosConfigurations.nixos.config.system.build.toplevel.drvPath' --no-write-lock-file
nix eval --raw '.#homeConfigurations."hapu@nixos".activationPackage.drvPath' --no-write-lock-file
```

## Build the editors

```bash
# Main Neovim configuration: nixcats/init.lua and nixcats/lua/
nix build .#nvim

# Alternate configuration: nvf/config/ and nvf/lua/
nix build .#nvf-nvim
```

These build packages; they do not activate a NixOS or Home Manager generation.

## Apply changes

```bash
sudo nixos-rebuild switch --flake .#nixos
home-manager switch --flake '.#hapu@nixos'
```

NixOS and Home Manager are separate outputs. Changes spanning both layers require
both switches. For portal ownership changes, apply NixOS first, then Home Manager,
and start a fresh desktop session before testing capture in each compositor.

## Configuration conventions

- Add user packages to `home-manager/core/packages/{cli,desktop,dev,gaming}.nix`.
  Check whether an enabled module already installs the same package first.
- Keep `pkgs-stable` in Home Manager for the documented `rar` workaround.
- Nushell completion files are referenced through Nix paths and sourced from the
  Nix store. Apply Home Manager again after editing them.
- NixOS owns portal routing in `nixos/desktop/portals.nix`: Hyprland handles its own
  capture, while niri keeps its module-provided GNOME/GTK routing. Home Manager's
  Hyprland `portalPackage = null` prevents a second portal setup.
- Ly and the KDE application packages live in `nixos/desktop/display.nix`; this
  does not enable the Plasma desktop.
- Keep dependency updates separate from structural cleanup. Use
  `nix flake update <input-name>` for a deliberate single-input update.

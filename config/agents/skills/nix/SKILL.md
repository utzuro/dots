---
name: nix
description: Ensure a project in the current or requested target directory has a flake.nix that supports nix build, nix run, and nix develop. Use when the user asks for /nix, flake setup, or Nix packaging for a project.
---

Make the current project, or the explicit target directory named by the user, usable with:

- `nix build`
- `nix run`
- `nix develop`

## Workflow

1. Resolve the target directory. If none is provided, use the current working directory.
2. Inspect the project before editing: existing `flake.nix`, lock files, manifest files, entrypoints, scripts, README, and nearby Nix files.
3. If `flake.nix` already exists, preserve its style and intent. Add or repair only the missing outputs.
4. If no runnable entrypoint or build target can be inferred, ask the user what `nix run` should execute instead of creating a fake app.
5. Keep the flake minimal. Prefer plain `nixpkgs` unless the project already uses helpers such as flake-parts.
6. Ensure the final flake exposes these outputs for the active system:
   - `packages.default` for `nix build`
   - `apps.default` for `nix run`
   - `devShells.default` for `nix develop`
7. Validate with non-destructive commands:
   - `nix flake show`
   - `nix build`
   - `nix develop -c true`
   - `nix run` only when the app is known to be safe; otherwise use a safe argument such as `--help` or ask first.

## Flake shape

For a new flake, start from this shape and adapt the package, app, and shell to the project:

```nix
{
  description = "Project flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in {
      packages = forAllSystems (system:
        let pkgs = pkgsFor system;
        in {
          default = pkgs.callPackage ./package.nix { };
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/<binary-name>";
        };
      });

      devShells = forAllSystems (system:
        let pkgs = pkgsFor system;
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ ];
          };
        });
    };
}
```

Do not keep `./package.nix` or `<binary-name>` unless those paths/names are real. Inline the derivation when it is simpler.

## Project heuristics

- Rust: use `rustPlatform.buildRustPackage`; set `cargoHash` from the build error when needed; include `cargo`, `rustc`, `rustfmt`, and `clippy` in the dev shell.
- Go: use `buildGoModule`; set `vendorHash` from the build error when needed; include `go` and common tools used by the repo.
- Node.js: prefer the lockfile-matching builder (`buildNpmPackage` for `package-lock.json`); set dependency hashes from build errors; expose the package binary or script that matches `package.json`.
- Python: use `buildPythonApplication` or `buildPythonPackage` when packaging metadata exists; for simple scripts, package the actual script and expose its command.
- Shell projects: use `writeShellApplication` or `stdenvNoCC.mkDerivation` with real scripts; include shellcheck/formatters only when useful.
- C/C++/Make projects: use `stdenv.mkDerivation` with the existing build/install commands; include the compiler and build tools in the dev shell.

## Rules

- Do not overwrite unrelated user changes.
- Do not generate lock files or vendored dependency files manually; run the appropriate Nix command and apply the resulting hash only when necessary.
- Do not hide broken builds with placeholder scripts. `nix build` must build the project artifact, and `nix run` must run the intended project command.
- Prefer asking one clarifying question over guessing when the project intent is ambiguous.

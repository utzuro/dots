---
name: build-nix-shell
description: Create a flake.nix that produces a nix shell with required environment.
compatibility: opencode
metadata:
  OS: NixOS
---

## What I do

- Understand which packages are required for the provided use-case.
  Usually checking the dependencies in README or asking user is a correct approach.
- Understand which configurations and shell hooks should be run
  to guarantee robust environment which can be relied in to provide anything
  current project / use-case would require.
- Search https://mynixos.com/ for the required packages and configurations.
- Search through the web for supporting examples for similar use cases that user has.
- Write a `flake.nix` file that exposes the shell with correct settings.

Template:
TBD

## When to use me

When user specifically asks to create a nix shell for a project.

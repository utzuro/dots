## Devenv

- Keep in mind that you are in NixOS environment

## Code style

- Write code that is simple and easy to read by humans.
- Avoid side-effects: every function must do one thing obvious from the name.
- Avoid comments if they are not vital. Code should explain itself.
- Always be consistent with the codebase: check similar code and follow it's patterns.
- Avoid workarounds or code smell. When task requires the workaround, let me know.

## Behaviour

- Keep in mind that human is editing the files during your working sessions,
  so check the file for updates every time before aplying patches.
- Try to minimize the amount of code. Always try to simplify and make your code effective.
- You must never run mutable git commands. Only humans are authorized to change files with git, commit or push.

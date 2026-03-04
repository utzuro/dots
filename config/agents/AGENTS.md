## Devenv

- Keep in mind that you are in NixOS environment

## Code style

- Write code that is simple and easy to read by humans.
- Avoid side-effects: every function must do one thing obvious from the name.
- Avoid comments if they are not vital. Code should explain itself.

## Behaviour

- Keep in mind that human is editing the files during your working sessions,
  so check for updates before aplying patches, don't rely solely on your snapshot of the file.
- Avoid workarounds or code smell. When task requires the workaround, let me know.
- Before proceeding with a big scale change, show examples and confirm with me.
- Try to minimize the amount of code. Always try to simplify and make your code effective.

# Pragmatic Hyprland Lua config guide

This is a practical guide for this config style, based on the mistakes that caused `SUPER+SHIFT+Q` to stop working.

## Mental model

Hyprland Lua config has two different worlds:

1. **Lua API / dispatchers**: `hl.dsp.window.kill()`, `hl.dsp.focus(...)`, `hl.config(...)`.
2. **Shell commands**: `kitty`, `uwsm app -- kitty`, `~/.config/hypr/kill.sh`.

Do not mix their syntax.

```lua
-- Lua dispatcher: no shell involved
hl.bind("SUPER + Q", hl.dsp.window.kill())

-- Shell command: runs through Hyprland exec
hl.bind("SUPER + Return", hl.dsp.exec_cmd("uwsm app -- kitty"))
```

In this repo we use a small helper:

```lua
local function sh(command)
  return hl.dsp.exec_cmd(command)
end
```

So these are equivalent:

```lua
hl.bind("SUPER + Return", hl.dsp.exec_cmd("uwsm app -- kitty"))
hl.bind("SUPER + Return", sh("uwsm app -- kitty"))
```

## Binds

General shape:

```lua
hl.bind("MODS + KEY", dispatcher_or_function, options)
```

Examples:

```lua
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", sh("uwsm app -- kitty"))
hl.bind(mainMod .. " + E", sh("uwsm app -- thunar"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
```

Options are a Lua table:

```lua
hl.bind("XF86AudioRaiseVolume", sh("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
  locked = true,
  repeating = true,
})

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
```

## Shell command vs Hyprland dispatcher

Use `hl.dsp.*` when Hyprland already has a dispatcher for the thing:

```lua
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
```

Use `sh(...)` / `hl.dsp.exec_cmd(...)` only for external programs or scripts:

```lua
hl.bind("SUPER + D", sh("uwsm app -- fuzzel"))
hl.bind("SUPER + P", sh("grim -g \"$(slurp)\" ~/pic.png"))
hl.bind("SUPER + SHIFT + Q", sh("~/.config/hypr/kill.sh"))
```

## `hyprctl dispatch` is Lua syntax here

With Lua config enabled, this old-style command is wrong:

```bash
hyprctl dispatch killactive ""
```

It fails because Hyprland tries to evaluate it as Lua-ish dispatch syntax.

Use this instead:

```bash
hyprctl dispatch 'hl.dsp.window.kill()'
```

More examples:

```bash
hyprctl dispatch 'hl.dsp.window.close()'
hyprctl dispatch 'hl.dsp.exit()'
hyprctl dispatch "hl.dsp.exec_cmd('kitty')"
```

Rule of thumb: if a script calls `hyprctl dispatch`, write the argument like the Lua dispatcher you would put in `hyprland.lua`.

## `uwsm app --` rule

Use `uwsm app -- ...` for launching long-lived GUI apps/services that should belong to the session:

```lua
hl.bind("SUPER + Return", sh("uwsm app -- kitty"))
hl.bind("SUPER + E", sh("uwsm app -- thunar"))
```

For short scripts or Hyprland control commands, direct execution is usually fine:

```lua
hl.bind("SUPER + SHIFT + R", sh("hyprctl reload"))
hl.bind("SUPER + SHIFT + Q", sh("~/.config/hypr/kill.sh"))
```

If a script launches GUI apps internally, put `uwsm app --` inside that script at the launch point.

## Safer script pattern

Prefer using Hyprland Lua dispatch syntax inside scripts:

```bash
#!/usr/bin/env bash

if [ "$(hyprctl activewindow -j | jq -r '.class')" = "Steam" ]; then
  xdotool getactivewindow windowunmap
else
  hyprctl dispatch 'hl.dsp.window.kill()'
fi
```

Avoid old dispatcher names in scripts unless you have confirmed they still work with Lua config.

## Config tables

Nested Hyprland config blocks become nested Lua tables:

```lua
hl.config({
  input = {
    kb_layout = "us,ua",
    kb_options = "grp:caps_toggle",
    follow_mouse = 1,

    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
    },
  },
})
```

Hyprland option names usually stay the same, but `section:option` becomes nesting:

```conf
input:kb_layout = us,ua
```

becomes:

```lua
hl.config({ input = { kb_layout = "us,ua" } })
```

## Events

Use events for startup and reactive behavior:

```lua
hl.on("hyprland.start", function()
  hl.exec_cmd("uwsm app -- hypridle")
  hl.dispatch(hl.dsp.focus({ workspace = 1 }))
end)
```

Inside callbacks:

- `hl.exec_cmd(...)` runs a command immediately.
- `hl.dispatch(hl.dsp....)` dispatches a Hyprland action immediately.
- `hl.dsp....` by itself only creates a dispatcher object.

## Testing workflow

After editing:

```bash
hyprctl reload
```

Check a bind exists:

```bash
hyprctl binds -j | jq '.[] | select(.key == "Q")'
```

Check the active submap:

```bash
hyprctl submap
```

Test a Lua dispatcher without pressing the key:

```bash
hyprctl dispatch 'hl.dsp.window.kill()'
```

Test shell exec through Hyprland:

```bash
hyprctl dispatch "hl.dsp.exec_cmd('printf ok > /tmp/hypr-test')"
cat /tmp/hypr-test
```

Test whether a physical hotkey fires without doing damage:

```bash
hyprctl dispatch "hl.bind('SUPER + SHIFT + Q', hl.dsp.exec_cmd('printf pressed > /tmp/hotkey-test'))"
# press SUPER+SHIFT+Q
cat /tmp/hotkey-test
hyprctl reload
```

`hyprctl reload` restores the bind from `hyprland.lua`.

## Keyboard layout gotcha

This config uses:

```lua
hl.config({
  input = {
    kb_layout = "us,ua",
    kb_options = "grp:caps_toggle",
  },
})
```

By default, Hyprland resolves binds using the first layout. If a key works in `us` but not in another layout, inspect:

```bash
hyprctl getoption input:resolve_binds_by_sym -j
hyprctl devices -j | jq '.keyboards[] | {name, active_keymap, layout}'
```

If needed, set:

```lua
hl.config({
  input = {
    resolve_binds_by_sym = true,
  },
})
```

Only enable it intentionally; it changes how bind keys are interpreted across layouts.

## Where to discover APIs

Current system example config:

```text
/nix/store/ndq4688w4wjlip63msnlxld8zwcwr66l-hyprland-0.55.2/share/hypr/hyprland.lua
```

Current system Lua stubs:

```text
/nix/store/ndq4688w4wjlip63msnlxld8zwcwr66l-hyprland-0.55.2/share/hypr/stubs/hl.meta.lua
```

The stubs show available functions such as:

```lua
hl.bind(...)
hl.config(...)
hl.on(...)
hl.dispatch(...)
hl.exec_cmd(...)
hl.dsp.exec_cmd(...)
hl.dsp.window.kill(...)
hl.dsp.window.close(...)
hl.dsp.focus(...)
```

## Practical rules

1. Use `hl.dsp.*` for Hyprland actions.
2. Use `sh(...)` only for shell commands and scripts.
3. In scripts, call Hyprland with Lua dispatch syntax: `hyprctl dispatch 'hl.dsp....()'`.
4. Use `uwsm app --` for launching GUI apps, not for every tiny script by default.
5. After changes, run `hyprctl reload` and inspect `hyprctl binds -j`.
6. When unsure, first bind to `printf pressed > /tmp/test` instead of destructive actions.

#!/usr/bin/env bash

set -e

repos=(
  # games
  ## strategy
  "https://github.com/vcmi/vcmi"
  "https://github.com/ihhub/fheroes2"
  "https://github.com/yairm210/Unciv"
  "https://github.com/dalerank/Akhenaten"
  "https://github.com/unknown-horizons/godot-port"
  "https://github.com/stefanhendriks/Dune-II---The-Maker"
  "https://github.com/dkfans/keeperfx"
  "https://github.com/widelands/widelands"
  "https://github.com/beyond-all-reason/Beyond-All-Reason"
  "https://github.com/citybound/citybound"
  "https://github.com/Uriopass/Egregoria"
  ## rpg
  "https://github.com/snesrev/zelda3"
  "https://github.com/naev/naev"
  "https://github.com/freeorion/freeorion"
  ## action
  "https://github.com/FrictionalGames/AmnesiaTheDarkDescent"
  "https://gitlab.com/drummyfish/anarch"
  "https://github.com/GlPortal/glPortal"
  "https://github.com/ioquake/ioq3"
  "https://github.com/fogleman/Craft"
  "https://github.com/OoliteProject/oolite"
  "https://github.com/arx/ArxLibertatis"
  "https://github.com/freeciv/freeciv"
  "https://github.com/electronicarts/CnC_Remastered_Collection"
  "https://github.com/Pyrdacor/Ambermoon.net"
  "https://github.com/Interkarma/daggerfall-unity"
  "https://github.com/OpenEnroth/OpenEnroth"
  "https://github.com/noxworld-dev/opennox"
  "https://github.com/seedhartha/reone"
  "https://github.com/ViridianGames/U7Revisited"
  "https://github.com/bixilon/minosoft"

  # code only
  ## strategy
  "https://github.com/OpenRA/OpenRA"
  "https://github.com/OpenHV/OpenHV"
  "https://github.com/DescentDevelopers/Descent3"
  "https://github.com/diasurgical/devilutionX"
  ## action
  "https://github.com/TTimo/doom3.gpl"
  "https://github.com/id-Software/DOOM"
  "https://github.com/id-Software/Quake-III-Arena"
  "https://github.com/id-Software/DOOM-3-BFG"
  "https://github.com/id-Software/Quake"
  "https://github.com/id-Software/Quake-2"
  "https://github.com/grayj/Jedi-Academy"
  "https://github.com/grayj/Jedi-Outcast"
  "https://github.com/JACoders/OpenJK"
  "https://github.com/exult/exult"
  "https://github.com/alexbatalov/fallout1-ce"
  "https://github.com/alexbatalov/fallout2-ce"
  # rust
  "https://github.com/veloren/veloren"
  # lisp
  "https://github.com/Shirakumo/Kandria"
  # assembly
  "https://github.com/jmechner/Prince-of-Persia-Apple-II"
  # lua
  "https://github.com/ZeroK-RTS/Zero-K"

  # cli
  "https://github.com/NetHack/NetHack"
  "https://github.com/OpenMW/openmw"


  "https://github.com/ocornut/imgui"
  "https://github.com/bevyengine/bevy"

  # engines
  "https://github.com/godotengine/godot"
  "https://github.com/SFTtech/openage"
  "https://github.com/eduard-permyakov/permafrost-engine"
  "https://github.com/FrictionalGames/HPL1Engine"

  # emulators
  "https://github.com/hrydgard/ppsspp"
  "https://github.com/RPCS3/rpcs3"
)

for repo in "${repos[@]}"; do
  repo_name=$(basename "$repo" .git)
  if [ ! -d "${repo_name}.git" ]; then
    echo "Cloning $repo..."
    git clone --depth=1 --single-branch --recurse-submodules "$repo" "${repo_name}.git"

  else
    echo "Updating $repo_name..."
    cd "${repo_name}.git" && git pull && git submodule update --depth=1 --recursive && cd ..

  fi
done


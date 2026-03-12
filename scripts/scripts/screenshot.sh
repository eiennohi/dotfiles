#!/usr/bin/env bash

set -e

DIR="$HOME/Pictures/Screenshots"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

mkdir -p "$DIR"
case "$1" in
  area)
    hyprctl keyword layerrule "noanim,selection" > /dev/null
    # get IDs of all currently active workspaces (normal + special) across all monitors
    WORKSPACES=$(hyprctl monitors -j | jq -c '[.[] | .activeWorkspace.id] + [.[] | select(.specialWorkspace.id != 0) | .specialWorkspace.id]')

    # filter clients in active workspaces and not hidden. Prioritize fullscreen windows
    WINDOWS=$(hyprctl clients -j | jq -r --argjson ws "$WORKSPACES" '
      map(select(.workspace.id as $id | $ws | contains([$id]))) 

      | group_by(.workspace.id) 
      | map(
          if any(.fullscreen == true) then 
            select(.fullscreen == true) 
          else 
            .[] 
          end
        ) 

      | .[] | select(.hidden == false) 
      | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
    )

    GEOM=$(echo "$WINDOWS" | slurp)

    [ -z "$GEOM" ] && exit 1

    grim -g "$GEOM" - | satty --filename - 
    ;;
  full)
    grim - | satty --filename - --output-filename "$FILE" --fullscreen
    ;;
  window)
    GEOM=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    grim -g "$GEOM" - | satty --filename - 
    ;;
  *)
    echo "Usage: screenshot {area|full|window}"
    exit 1
    ;;
esac

echo "Saved to $FILE"

#!/bin/bash
set -e
function cleanup {
  echo "Unndo changes: "$MODE_TITLE;
  xrandr --output VIRTUAL1 --off
  xrandr --delmode VIRTUAL1 "$MODE_TITLE"
  xrandr --rmmode $MODE_TITLE
}
trap cleanup EXIT
if ([ -z "$1" ]) || ([ -z "$2" ]); then 
MODE_TITLE="448x800_24.00"
MODE="\"448x800_24.00\" 13.28  448 456 496 544  800 801 804 814  -HSync +Vsync"
echo "used default param $MODE";
else
MODE=$(gtf $1 $2 24 | grep "Modeline" | cut -c 12-)
MODE_TITLE=$(echo $1"x"$2"_24.00")
echo $MODE_TITLE;
echo $MODE;
fi
echo "Creating mode: $MODE";
eval xrandr --newmode $MODE
echo "Adding mode: $MODE_TITLE";
eval xrandr --addmode VIRTUAL1 "$MODE_TITLE"
echo "Enabling mode: $MODE_TITLE";
xrandr --output VIRTUAL1 --auto
echo "Launching teamviewer";
teamviewer

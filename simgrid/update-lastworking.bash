#!/usr/bin/env bash
set -eu

# Retrieve the last SimGrid working version
revision=$(\
  curl -s https://ci.inria.fr/simgrid/job/SimGrid/lastSuccessfulBuild/ |\
  grep -o '<b>Revision</b>.*' |\
  cut -d' ' -f2)
echo "Last working SimGrid revision is ${revision}"

# Update dev_working.nix
sed -i "s/rev = \".*\";/rev = \"${revision}\";/" dev_working.nix

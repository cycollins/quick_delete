#!/bin/bash

declare -i auto_yes=0
declare -i blue_ocean=0

for arg in $*; do
  case "$arg" in
    -o)
      blue_ocean=1
      ;;
    -y)
      auto_yes=1
      ;;
  esac
done

(( "$blue_ocean" == 0 )) && declare -r organization="" || declare -r organization="blue-ocean-robotics/"
[[ -z "$organization" ]] && echo "default organization" || echo "organization is Blue Ocean"

if (( "$auto_yes" == 0 )); then
  read -p "Are you sure? " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo  "proceeding..."
  else
    echo "aborting..."
    exit -1
  fi
fi

declare -ra submodule_names=( qtandroidextras qtbase qtdeclarative qtdoc qtgraphicaleffects qtimageformats qtlocation qtmacextras qtmultimedia qtqa qtquickcontrols qtquickcontrols2 qtrepotools qtsensors qtsvg qttools qttranslations qtvirtualkeyboard qtwebview qtwinextras qtxmlpatterns )

for repo in ${submodule_names[@]}; do
   hub delete -y "${organization}qt_${repo}"
done

hub delete -y "${organization}qt"

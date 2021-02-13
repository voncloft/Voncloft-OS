#!/bin/bash

#
# Copyright © 2018-2020, Sébastien Luttringer
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

# display what to run and run it quietly
run() {
  echo "==> $*"
  "$@" > /dev/null
  local ret=$?
  (( $ret )) && echo "==> Warning, \`$*' returned $ret"
  return $ret
}

# check whether the dependencies of a module are installed
# $1: module name
# $2: module version
# $3: kernel version
check_dependency() { (
  source "$source_tree/$1-$2/dkms.conf"
  local mod lines line
  for mod in "${BUILD_DEPENDS[@]}"; do
    mapfile lines < <(dkms status -m "$mod" -k "$3")
    for line in "${lines[@]}"; do
      [[ "$line" =~ "$mod, "[^,]+", $3, "[^:]+': installed' ]] && break 2
    done
    exit 1
  done
  exit 0
) }

# check whether the modules should be built with this kernel version
# $1: module name
# $2: module version
# $3: kernel version
check_buildexclusive() {
  local BUILD_EXCLUSIVE_KERNEL=$(source "$source_tree/$1-$2/dkms.conf"; printf '%s\n' "$BUILD_EXCLUSIVE_KERNEL")
  [[ "$3" =~ $BUILD_EXCLUSIVE_KERNEL ]]
}

# handle actions on module addition/upgrade/removal
# $1: module name
# $2: module version
parse_module() {
  pushd "$install_tree" >/dev/null
  local path
  for path in */build/; do
    local kver="${path%%/*}"
    dkms_register "$1" "$2" "$kver"
  done
  popd >/dev/null
}

# handle actions on kernel addition/upgrade/removal
# $1: kernel version
parse_kernel() {
  local path
  for path in "$source_tree"/*-*/dkms.conf; do
    if [[ -f "$path" && "$path" =~ ^$source_tree/([^/]+)-([^/]+)/dkms\.conf$ ]]; then
      dkms_register "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "$1"
    fi
  done
}

# register a dkms module to install/remove
# this function suppress echo call for a module
# $1: module name, $2: module version, $3: kernel version
dkms_register() {
  DKMS_MODULES["$1/$2/$3"]=''
}

# install registered modules
dkms_install() {
  local nvk mod mver kver
  local -i retry=1
  local -A dmods=()

  while (( $retry > 0 )); do
    retry=0
    for nvk in "${!DKMS_MODULES[@]}"; do
      [[ "$nvk" =~ ([^/]+)/([^/]+)/(.+) ]]
      mod="${BASH_REMATCH[1]}"
      mver="${BASH_REMATCH[2]}"
      kver="${BASH_REMATCH[3]}"
      # do not build excluded modules
      if ! check_buildexclusive "$mod" "$mver" "$kver"; then
        unset DKMS_MODULES[$nvk]
        continue
      # skip modules with missing kernel headers
      elif [[ ! -d "$install_tree/$kver/build/include" ]]; then
        DKMS_MODULES[$nvk]='Missing kernel headers'
        continue
      # skip modules with missing kernel package
      elif [[ ! -d "$install_tree/$kver/kernel" ]]; then
        DKMS_MODULES[$nvk]='Missing kernel modules tree'
        continue
      # postpone modules with missing dependencies
      elif ! check_dependency "$mod" "$mver" "$kver"; then
        DKMS_MODULES[$nvk]='Missing dependency'
        continue
      fi
      # give it a try dkms
      run dkms install --no-depmod -m "$mod" -v "$mver" -k "$kver"
      dmods[$kver]=''
      unset DKMS_MODULES[$nvk]
      # maybe this module was a dep of another, so we retry
      retry=1
    done
  done
  # run depmod later for performance improvments
  if (( $DKMS_DEPMOD )); then
    for kver in "${!dmods[@]}"; do
      run depmod "$kver"
    done
  fi
}

# remove registered modules when built/installed
# run depmod later for performance improvments
dkms_remove() {
  local nvk mod mver kver state
  local -A dmods=()
  for nvk in "${!DKMS_MODULES[@]}"; do
    [[ "$nvk" =~ ([^/]+)/([^/]+)/(.+) ]]
    mod="${BASH_REMATCH[1]}"
    mver="${BASH_REMATCH[2]}"
    kver="${BASH_REMATCH[3]}"
    # do not remove excluded modules (n.b. display not found errors)
    if ! check_buildexclusive "$mod" "$mver" "$kver"; then
      unset DKMS_MODULES[$nvk]
      continue
    fi
    state=$(dkms status -m "$mod" -v "$mver" -k "$kver")
    if [[ "$state" =~ "$mod, $mver, $kver, "[^:]+": "(added|built|installed) ]]; then
      dmods[$kver]=''
      run dkms remove --no-depmod -m "$mod" -v "$mver" -k "$kver"
      if (( $? == 0 )); then
        unset DKMS_MODULES[$nvk]
      else
        DKMS_MODULES[$nvk]='dkms remove failed'
      fi
    else
      DKMS_MODULES[$nvk]='Not found in dkms status output'
    fi
  done
  # run depmod later for performance improvments
  if (( $DKMS_DEPMOD )); then
    for kver in "${!dmods[@]}"; do
      run depmod "$kver"
    done
  fi
}

# show information about failed modules
show_errors() {
  local nvk mod kver
  for nvk in "${!DKMS_MODULES[@]}"; do
    mod=${nvk%/*}
    kver=${nvk##*/}
    echo "==> Unable to $DKMS_ACTION module $mod for kernel $kver: ${DKMS_MODULES[$nvk]}."
  done
}

# display hook usage and exit $1 (default 1)
usage() {
  cat << EOF >&2
usage: ${0##*/} <options> install|remove
options: -D  Do not run depmod
EOF
  exit ${1:-1}
}

# emulated program entry point
main() {
  [[ "$DKMS_ALPM_HOOK_DEBUG" ]] && set -x

  # prevent each dkms call from failing with authorization errors
  if (( EUID )); then
    echo 'You must be root to use this hook' >&2
    exit 1
  fi

  # parse command line options
  declare -i DKMS_DEPMOD=1
  local opt
  while getopts 'hD' opt; do
    case $opt in
      D) DKMS_DEPMOD=0;;
      *) usage;;
    esac
  done
  shift $((OPTIND - 1))
  (( $# != 1 )) && usage

  # register DKMS action
  case "$1" in
    install|remove)
      declare -r DKMS_ACTION="$1";;
    *) usage;;
  esac

  # dkms path from framework config
  # note: the alpm hooks which trigger this script use static path
  source_tree='/usr/src'
  install_tree='/usr/lib/modules'
  source /etc/dkms/framework.conf

  # check source_tree and install_tree exists
  local path
  for path in "$source_tree" "$install_tree"; do
    if [[ ! -d "$path" ]]; then
      echo "==> Missing mandatory directory: $path. Exiting!"
      return 1
    fi
  done

  # storage for DKMS modules to install/remove
  # we use associate arrays to prevent duplicate
  declare -A DKMS_MODULES

  # parse stdin paths to guess what do do
  while read -r path; do
    if [[ "/$path" =~ ^$source_tree/([^/]+)-([^/]+)/dkms\.conf$ ]]; then
      parse_module "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    elif [[ "/$path" =~ ^$install_tree/([^/]+)/ ]]; then
      parse_kernel "${BASH_REMATCH[1]}"
    fi
  done

  dkms_$DKMS_ACTION

  show_errors

  return 0
}

main "$@"

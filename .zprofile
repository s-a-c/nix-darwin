## [_field]  ## {{{
##[_field.test] ## {{{
## SYNOPSIS: _field_test
## EXAMPLE: _field_test
## DESCRIPTION: Test function for the _field library.
##              It tests all the functions in the library.
##              It is not meant to be called directly.
##              It is meant to be called from the _test function.
function _field_test() {
  local varName=PATH fieldNum=2 fieldVal=/usr/local/bin fieldVal2=/usr/local/bin2
  local auxArr
  printf -v "$varName" '%s' '/usr/bin:/usr/local/bin:/bin:/usr/sbin'
  _field_get "$varName" "$fieldNum"
  _field_set "$varName" "$fieldNum" "$fieldVal"
  _field_insert "$varName" "$fieldNum" "$fieldVal"
  _field_delete "$varName" "$fieldNum"
  _field_find "$varName" "$fieldVal"
  _field_replace "$varName" "$fieldVal" "$fieldVal2"
  _field_contains "$varName" "$fieldVal"
  _field_append "$varName" "$fieldVal"
  _field_prepend "$varName" "$fieldVal"
  _field_append "$varName" "$fieldVal"
  _field_remove "$varName" "$fieldVal"
}
## }}}  ## [_field.test]

## [_field.get] ## {{{
## SYNOPSIS: field_get varName fieldNum [sep]
##   SEP defaults to ':'
## EXAMPLE: field_get PATH 2
function _field_get() {
  printf "$# : $@"
  local varName=$1 fieldNum=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  printf '%s' "${auxArr[fieldNum]}"
}
## }}}  ## [_field.get]

## [_field.set] ## {{{
## SYNOPSIS: field_set varName fieldNum fieldVal [sep]
##   SEP defaults to ':'
## EXAMPLE: field_set PATH 2 /usr/local/bin
function _field_set() {
  local varName=$1 fieldNum=$2 fieldVal=$3 IFS=${4:-':'}
  read -ra auxArr <<< "${!varName}"
  auxArr[fieldNum]="$fieldVal"
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.set]

## [_field.insert] ## {{{
## SYNOPSIS: field_insert varName fieldNum fieldVal [sep]
##   SEP defaults to ':'
## EXAMPLE: field_insert PATH 2 /usr/local/bin
function _field_insert() {
  local varName=$1 fieldNum=$2 fieldVal=$3 IFS=${4:-':'}
  read -ra auxArr <<< "${!varName}"
  auxArr=("${auxArr[@]:0:fieldNum}" "$fieldVal" "${auxArr[@]:fieldNum}")
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.insert]

## [_field.delete] ## {{{
## SYNOPSIS: field_delete varName fieldNum [sep]
##   SEP defaults to ':'
## EXAMPLE: field_delete PATH 2
function _field_delete() {
  local varName=$1 fieldNum=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  unset 'auxArr[fieldNum]'
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.delete]

## [_field.find] ## {{{
## SYNOPSIS: field_find varName fieldVal [sep]
##   SEP defaults to ':'
## EXAMPLE: field_find PATH /usr/local/bin
function _field_find() {
  local varName=$1 fieldVal=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  for i in "${!auxArr[@]}"; do
      [[ ${auxArr[i]} == "$fieldVal" ]] && return 0
  done
  return 1
}
## }}}  ## [_field.find]

## [_field.replace] ## {{{
## SYNOPSIS: field_replace varName fieldVal newFieldVal [sep]
##   SEP defaults to ':'
## EXAMPLE: field_replace PATH /usr/local/bin /usr/local/bin2
function _field_replace() {
  local varName=$1 fieldVal=$2 newFieldVal=$3 IFS=${4:-':'}
  read -ra auxArr <<< "${!varName}"
  for i in "${!auxArr[@]}"; do
      [[ ${auxArr[i]} == "$fieldVal" ]] && auxArr[i]="$newFieldVal"
  done
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.replace]

## [_field.contains] ## {{{
## SYNOPSIS: field_contains varName fieldVal [sep]
##   SEP defaults to ':'
## EXAMPLE: field_contains PATH /usr/local/bin
function _field_contains() {
  local varName=$1 fieldVal=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  for i in "${!auxArr[@]}"; do
      [[ ${auxArr[i]} == "$fieldVal" ]] && return 0
  done
  return 1
}
## }}}  ## [_field.contains]

## [_field.append] ## {{{
## SYNOPSIS: field_append varName fieldVal [sep]
##   SEP defaults to ':'
## Note: Forces fieldVal into the last position, if already present.
##       Duplicates are removed, too.
## EXAMPLE: field_append PATH /usr/local/bin
function _field_append() {
  local varName=$1 fieldVal=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  for i in "${!auxArr[@]}"; do
      [[ ${auxArr[i]} == "$fieldVal" ]] && unset 'auxArr[i]'
  done
  auxArr+=("$fieldVal")
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.append]

## [_field.prepend] ## {{{
## SYNOPSIS: field_prepend varName fieldVal [sep]
##   SEP defaults to ':'
## Note: Forces fieldVal into the first position, if already present.
##       Duplicates are removed, too.
## EXAMPLE: field_prepend PATH /usr/local/bin
function _field_prepend() {
  local varName=$1 fieldVal=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  for i in "${!auxArr[@]}"; do
      [[ ${auxArr[i]} == "$fieldVal" ]] && unset 'auxArr[i]'
  done
  auxArr=("$fieldVal" "${auxArr[@]}")
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.prepend]

## [_field.remove] ## {{{
## SYNOPSIS: field_remove varName fieldVal [sep]
##   SEP defaults to ':'
## Note: Duplicates are removed, too.
## EXAMPLE: field_remove PATH /usr/local/bin
function _field_remove() {
  local varName=$1 fieldVal=$2 IFS=${3:-':'}
  read -ra auxArr <<< "${!varName}"
  for i in "${!auxArr[@]}"; do
      [[ ${auxArr[i]} == "$fieldVal" ]] && unset 'auxArr[i]'
  done
  printf -v "$varName" '%s' "${auxArr[*]}"
}
## }}}  ## [_field.remove]
## }}}  ## [_field]


## [_path]  ## {{{
## [_path.remove] ## {{{
function _path_remove() {
  for ARG in "$@"; do
    while [[ ":$PATH:" == *":$ARG:"* ]]; do
      ## Delete path by parts so we can never accidentally remove sub paths
      [[ "$PATH" == "$ARG" ]] && PATH=""
      PATH=${PATH//":$ARG:"/":"}  ## delete any instances in the middle
      PATH=${PATH/#"$ARG:"/}  ## delete any instance at the beginning
      PATH=${PATH/%":$ARG"/}  ## delete any instance in the at the end
      export PATH
    done
  done
}
## }}}  ## [_path.remove]

## [_path.append] ## {{{
function _path_append() {
  for ARG in "$@"; do
    _path_remove "$ARG"
    [[ -d "$ARG" ]] && export PATH="${PATH:+"$PATH:"}$ARG"
  done
}
## }}}  ## [_path.append]

## [_path.prepend]  ## {{{
function _path_prepend() {
  for ARG in "$@"; do
    _path_remove "$ARG"
    [[ -d "$ARG" ]] && export PATH="$ARG${PATH:+":$PATH"}"
  done
}
## }}}  ## [_path.prepend]
## }}}  ## [_path]

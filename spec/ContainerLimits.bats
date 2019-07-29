#!/usr/bin/env bats

@test 'ContainerLimits' {
  run dhall-to-yaml --omitNull <<< '
    let types = ./types.dhall
    let builders = ./builders.dhall
    let limits : types.ContainerLimits = builders.makeContainerLimits
    in limits
  '
  [ "$status" -eq 0 ]
  local actual="$output"

  run yamldiff \
    --file1 <( printf '{}' ) \
    --file2 <( echo "$actual" )
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test 'ContainerLimits: Optional cpu' {
  run dhall-to-yaml --omitNull <<< '
    let types = ./types.dhall
    let builders = ./builders.dhall
    let limits : types.ContainerLimits = builders.makeContainerLimits
      // { cpu = Some 123 }
    in limits
  '
  echo "$output"
  [ "$status" -eq 0 ]
  local actual="$output"

  run yamldiff \
    --file1 <( printf 'cpu: 123' ) \
    --file2 <( echo "$actual" )
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test 'ContainerLimits: Optional memory' {
  run dhall-to-yaml --omitNull <<< '
    let types = ./types.dhall
    let builders = ./builders.dhall
    let limits : types.ContainerLimits = builders.makeContainerLimits
      // { memory = Some 123 }
    in limits
  '
  echo "$output"
  [ "$status" -eq 0 ]
  local actual="$output"

  run yamldiff \
    --file1 <( printf 'memory: 123' ) \
    --file2 <( echo "$actual" )
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}



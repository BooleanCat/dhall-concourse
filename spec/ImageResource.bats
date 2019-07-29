#!/usr/bin/env bats

@test 'ImageResource' {
  run dhall-to-yaml --omitNull <<< '
    let types = ./types.dhall
    let builders = ./builders.dhall in
    let resource : types.ImageResource = builders.makeImageResource "foo"
    in resource
  '
  [ "$status" -eq 0 ]
  local actual="$output"

  run yamldiff \
    --file1 <( printf 'type: foo' ) \
    --file2 <( echo "$actual" )
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test 'ImageResource: Optional source' {
  run dhall-to-yaml --omitNull <<< '
    let JSON = https://prelude.dhall-lang.org/JSON/package.dhall
    let types = ./types.dhall
    let builders = ./builders.dhall in
    let resource : types.ImageResource = builders.makeImageResource "foo"
      // { source = Some (JSON.object[{ mapKey = "foo", mapValue = JSON.string "bar" }]) }
    in resource
  '
  [ "$status" -eq 0 ]
  local actual="$output"

  run yamldiff \
    --file1 <( printf 'type: foo\nsource:\n  foo: bar' ) \
    --file2 <( echo "$actual" )
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test 'ImageResource: Optional params' {
  run dhall-to-yaml --omitNull <<< '
    let JSON = https://prelude.dhall-lang.org/JSON/package.dhall
    let types = ./types.dhall
    let builders = ./builders.dhall in
    let resource : types.ImageResource = builders.makeImageResource "foo"
      // { params = Some (JSON.object[{ mapKey = "foo", mapValue = JSON.string "bar" }]) }
    in resource
  '
  echo "$output"
  [ "$status" -eq 0 ]
  local actual="$output"

  run yamldiff \
    --file1 <( printf 'type: foo\nparams:\n  foo: bar' ) \
    --file2 <( echo "$actual" )
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

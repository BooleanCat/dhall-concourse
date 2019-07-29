let JSON = https://prelude.dhall-lang.org/JSON/Type

in

{ imageResource = {
    type = ""
  , source = None JSON
  , params = None JSON
  , version = None ( List { mapKey : Text, mapValue : Text } )
  }
}

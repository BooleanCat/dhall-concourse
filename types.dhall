let JSON = https://prelude.dhall-lang.org/JSON/Type

in

{ ImageResource = {
    type    : Text
  , source  : Optional JSON
  , params  : Optional JSON
  , version : Optional ( List { mapKey : Text, mapValue : Text } )
  }

, ContainerLimits = {
    cpu    : Optional Natural
  , memory : Optional Natural
  }
}

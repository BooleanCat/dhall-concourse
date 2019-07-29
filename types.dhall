let JSON = https://prelude.dhall-lang.org/JSON/Type

in

{ ImageResource = {
    type   : Text
  , source : Optional JSON
  , params : Optional JSON
  }
}

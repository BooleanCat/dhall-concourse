let types = ./types.dhall
let defaults = ./defaults.dhall
let JSON = https://prelude.dhall-lang.org/JSON/Type

in

{ makeImageResource =
  λ(type : Text) →
    let imageResource : types.ImageResource = defaults.imageResource
      // { type = type }
    in imageResource

, makeContainerLimits = defaults.containerLimits
}

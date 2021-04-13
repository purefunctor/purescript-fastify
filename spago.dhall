{ name = "fastify"
, dependencies =
  [ "console"
  , "effect"
  , "foreign"
  , "foreign-object"
  , "prelude"
  , "psci-support"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

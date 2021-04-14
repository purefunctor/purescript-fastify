{ name = "fastify"
, dependencies =
  [ "aff"
  , "console"
  , "effect"
  , "foreign"
  , "foreign-object"
  , "functions"
  , "prelude"
  , "psci-support"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

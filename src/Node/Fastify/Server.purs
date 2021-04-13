module Node.Fastify.Server where

import Effect (Effect)

-- | Represents a `fastify` server.
foreign import data Server :: Type

-- | Represents options to be passed to the `fastify` server factory.
-- |
-- | NOTE: Record fields marked by TODO are either from foreign
-- | libraries or are unions of multiple types. There are no plans
-- | to support this currently.
-- |
-- | Reference: https://github.com/fastify/fastify/blob/v3.14.2/docs/Server.md
newtype ServerOptions = ServerOptions
  { http2 :: Boolean
  -- , https :: Unit -- TODO
  , connectionTimeout :: Number
  , keepAliveTimeout :: Number
  , ignoreTrailingSlash :: Boolean
  , maxParamLength :: Number
  , bodyLimit :: Number
  , onProtoPoisoning :: String
  , onConstructorPoisoning :: String
  -- , logger :: Unit -- TODO
  , disableRequestLogging :: Boolean
  -- , serverFactory :: Unit -- TODO
  , caseSensitive :: Boolean
  , requestIdHeader :: String
  , requestIdLogLabel :: String
  -- , genReqId :: Unit -- TODO
  -- , trustProxy :: Unit -- TODO
  , pluginTimeout :: Number
  -- , querystringParser :: Unit
  , exposeHeadRoutes :: Boolean
  -- , constraints :: Unit -- TODO
  , return503OnClosing :: Boolean
  -- , ajv :: Unit -- TODO
  , http2SessionTimeout :: Number
  -- , frameworkErrors :: Unit -- TODO
  -- , clientErrorHandler :: Unit -- TODO
  -- , rewriteUrl :: Unit -- TODO
  }

-- | Provides default server options.
-- |
-- | NOTE: Record fields marked by TODO are either from foreign
-- | libraries or are unions of multiple types. There are no plans
-- | to support this currently.
-- |
-- | Reference: https://github.com/fastify/fastify/blob/v3.14.2/docs/Server.md
defaultServerOptions :: ServerOptions
defaultServerOptions = ServerOptions
  { http2: false
  -- , https: unit
  , connectionTimeout: 0.0
  , keepAliveTimeout: 5.0
  , ignoreTrailingSlash: false
  , maxParamLength: 100.0
  , bodyLimit: 1048576.0
  , onProtoPoisoning: "error"
  , onConstructorPoisoning: "ignore"
  -- , logger: unit
  , disableRequestLogging: false
  -- , serverFactory: unit
  , caseSensitive: true
  , requestIdHeader: "request-id"
  , requestIdLogLabel: "reqId"
  -- , genReqId: unit
  -- , trustProxy: unit
  , pluginTimeout: 10000.0
  -- , querystringParser: unit
  , exposeHeadRoutes: false
  -- , constraints: unit
  , return503OnClosing: true
  -- , ajv: unit
  , http2SessionTimeout: 5000.0
  -- , frameworkErrors: unit
  -- , clientErrorHandler: unit
  -- , rewriteUrl: unit
  }

foreign import _mkServer :: ServerOptions -> Effect Server

-- | Creates a `Server` given `ServerOptions`.
mkServer :: ServerOptions -> Effect Server
mkServer = _mkServer

module Node.Fastify.Server where

import Prelude

import Data.Function.Uncurried (Fn2, Fn4, runFn2, runFn4)
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Node.Fastify.Handler (Handler, runHandler)
import Node.Fastify.Types (FastifyServer, HandlerFn, HttpMethod(..))

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

foreign import _mkServer :: ServerOptions -> Effect FastifyServer

-- | Creates a `FastifyServer` given `ServerOptions`.
mkServerWithOptions :: ServerOptions -> Effect FastifyServer
mkServerWithOptions = _mkServer

-- | Creates a `FastifyServer` with `defaultServerOptions`.
mkServer :: Effect FastifyServer
mkServer = mkServerWithOptions defaultServerOptions

-- | Monad for operating on a `FastifyServer`.
newtype ServerM r = ServerM (FastifyServer -> Effect r)

type Server = ServerM Unit

runServer :: FastifyServer -> Server -> Effect Unit
runServer s ( ServerM m ) = m s

instance functorServerM :: Functor ServerM where
  map f ( ServerM m ) = ServerM \s -> f <$> m s

instance applyServerM :: Apply ServerM where
  apply ( ServerM f ) ( ServerM m ) = ServerM \s -> do
    f' <- f s
    m' <- m s
    pure $ f' m'

instance applicativeServerM :: Applicative ServerM where
  pure r = ServerM \_ -> pure r

instance bindServerM :: Bind ServerM where
  bind ( ServerM m ) f = ServerM \s ->
    f <$> m s >>= \(ServerM n) -> n s

instance monadServerM :: Monad ServerM

instance monadEffectServerM :: MonadEffect ServerM where
  liftEffect m = ServerM \_ -> m

foreign import _http :: Fn4 FastifyServer String String HandlerFn ( Effect Unit )

-- | Binds a handler to a specific route and method.
http :: HttpMethod -> String -> Handler -> Server
http method route handler = ServerM \s ->
  liftEffect $ runFn4 _http s ( show method ) route ( runHandler handler )

-- | Shorthand for `http GET`
get :: String -> Handler -> Server
get = http GET

-- | Shorthand for `http POST`
post :: String -> Handler -> Server
post = http POST

-- | Shorthand for `http PUT`
put :: String -> Handler -> Server
put = http PUT

-- | Shorthand for `http DELETE`
delete :: String -> Handler -> Server
delete = http DELETE

-- | Shorthand for `http ALL`
all :: String -> Handler -> Server
all = http ALL

foreign import _listen :: Fn2 FastifyServer Int ( Effect Unit )

-- | Runs a `Server` on a given port
listen :: Server -> Int -> Effect Unit
listen ( ServerM m ) p = do
  s <- mkServer
  m s
  runFn2 _listen s p

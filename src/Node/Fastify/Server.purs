module Node.Fastify.Server where

import Prelude

import Data.Function.Uncurried (Fn2, Fn4, runFn2, runFn4)
import Data.Options (Option, Options(..), opt, options, (:=))
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Foreign (Foreign)
import Node.Fastify.Handler (Handler, runHandler)
import Node.Fastify.Types (FastifyServer, HandlerFn, HttpMethod(..), Port)


data HttpsOptions = HttpsOptions

key :: Option HttpsOptions String
key = opt "key"

cert :: Option HttpsOptions String
cert = opt "cert"

data AjvOptions = AvjOptions

customOptions :: Option AjvOptions AjvCustomOptions
customOptions = opt "customOptions"

plugins :: Option AjvOptions ( Array Foreign )
plugins = opt "plugins"

data AjvCustomOptions = AjvCustomOptions

removeAdditional :: Option AjvCustomOptions Boolean
removeAdditional = opt "removeAdditional"

useDefaults :: Option AjvCustomOptions Boolean
useDefaults = opt "useDefaults"

coerceTypes :: Option AjvCustomOptions Boolean
coerceTypes = opt "coerceTypes"

allErrors :: Option AjvCustomOptions Boolean
allErrors = opt "allErrors"

nullable :: Option AjvCustomOptions Boolean
nullable = opt "nullable"

data ServerOptions = ServerOptions

http2 :: Option ServerOptions Boolean
http2 = opt "http2"

https :: Option ServerOptions Foreign
https = opt "https"

connectionTimeout :: Option ServerOptions Number
connectionTimeout = opt "connectionTimeout"

keepAliveTimeout :: Option ServerOptions Number
keepAliveTimeout = opt "keepAliveTimeout"

ignoreTrailingSlash :: Option ServerOptions Number
ignoreTrailingSlash = opt "ignoreTrailingSlash"

maxParamLength :: Option ServerOptions Number
maxParamLength = opt "maxParamLength"

bodyLimit :: Option ServerOptions Number
bodyLimit = opt "bodyLimit"

onProtoPoisoning :: Option ServerOptions String
onProtoPoisoning = opt "onProtoPoisoning"

onConstructorPoisoning :: Option ServerOptions String
onConstructorPoisoning = opt "onConstructorPoisoning"

logger :: Option ServerOptions Foreign
logger = opt "logger"

disableRequestLoggingq :: Option ServerOptions Boolean
disableRequestLoggingq = opt "disableRequestLoggingq"

serverFactory :: Option ServerOptions Foreign
serverFactory = opt "serverFactory"

caseSensitive :: Option ServerOptions Boolean
caseSensitive = opt "caseSensitive"

requestIdHeader :: Option ServerOptions String
requestIdHeader = opt "requestIdHeader"

requestIdLogLabel :: Option ServerOptions String
requestIdLogLabel = opt "requestIdLogLabel"

genReqId :: Option ServerOptions Foreign
genReqId = opt "genReqId"

trustProxy :: Option ServerOptions Foreign
trustProxy = opt "trustProxy"

pluginTimeout :: Option ServerOptions Number
pluginTimeout = opt "pluginTimeout"

querystringParser :: Option ServerOptions Foreign
querystringParser = opt "querystringParser"

exposeHeadRoutes :: Option ServerOptions Boolean
exposeHeadRoutes = opt "exposeHeadRoutes"

constraints :: Option ServerOptions Foreign
constraints = opt "constraints"

return503OnClosing :: Option ServerOptions Boolean
return503OnClosing = opt "return503OnClosing"

ajv :: Option ServerOptions Foreign
ajv = opt "ajv"

http2SessionTimeout :: Option ServerOptions Number
http2SessionTimeout = opt "http2SessionTimeout"

frameworkErrors :: Option ServerOptions Foreign
frameworkErrors = opt "frameworkErrors"

clientErrorHandler :: Option ServerOptions Foreign
clientErrorHandler = opt "clientErrorHandler"

rewriteUrl :: Option ServerOptions Foreign
rewriteUrl = opt "rewriteUrl"

foreign import _mkServer :: Foreign -> Effect FastifyServer

-- | Creates a `FastifyServer` given `ServerOptions`.
mkServerWithOptions :: Options ServerOptions -> Effect FastifyServer
mkServerWithOptions = _mkServer <<< options

-- | Creates a `FastifyServer` with default options.
mkServer :: Effect FastifyServer
mkServer = mkServerWithOptions $ Options [ ]


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

-- | Runs a `Server` on a `Port` given `ServerOptions`.
listenWithOptions :: Options ServerOptions -> Server -> Port -> Effect Unit
listenWithOptions options ( ServerM m ) port = do
  server <- mkServerWithOptions options
  m server
  runFn2 _listen server port

-- | Runs a `Server` on a `Port` with default options.
listen :: Server -> Port -> Effect Unit
listen = listenWithOptions $ Options [ ]

-- | Runs a `Server` on a `Port` with HTTPS given `HttpsOptions`.
listenHttps :: Options HttpsOptions -> Server -> Port -> Effect Unit
listenHttps httpsOpt server port =
  let serverOpt = https := (options httpsOpt)
   in listenWithOptions serverOpt server port

module Node.Fastify.Request where

import Effect (Effect)
import Foreign (Foreign)
import Foreign.Object (Object)
import Node.Fastify.Types (Request)

foreign import _getBody :: Request -> Effect ( Object Foreign )

foreign import _getQuery :: Request -> Effect ( Object Foreign )

foreign import _getHeaders :: Request -> Effect ( Object Foreign )

foreign import _getParams :: Request -> Effect ( Object Foreign )

foreign import _getId :: Request -> Effect String

foreign import _getIp :: Request -> Effect String

foreign import _getHostname :: Request -> Effect String

foreign import _getProtocol :: Request -> Effect String

foreign import _getMethod :: Request -> Effect String

foreign import _getUrl :: Request -> Effect String

foreign import _getRouterMethod :: Request -> Effect String

foreign import _getRouterPath :: Request -> Effect String

foreign import _getIs404 :: Request -> Effect Boolean

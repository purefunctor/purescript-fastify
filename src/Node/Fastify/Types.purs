module Node.Fastify.Types where

import Prelude

import Effect (Effect)

-- | Represents a `fastify` server.
foreign import data FastifyServer :: Type

-- | Represents a `fastify` request.
foreign import data FastifyRequest :: Type

-- | Represents a `fastify` reply.
foreign import data FastifyReply :: Type

-- | Represents a handler in PureScript
type HandlerFn = ( FastifyRequest -> FastifyReply -> Effect Unit )

-- | Represents HTTP methods.
data HttpMethod
  = GET
  | POST
  | PUT
  | DELETE
  | ALL

derive instance eqHttpMethod :: Eq HttpMethod

instance showHttpMethod :: Show HttpMethod where
  show GET = "get"
  show POST = "post"
  show PUT = "put"
  show DELETE = "delete"
  show ALL = "all"

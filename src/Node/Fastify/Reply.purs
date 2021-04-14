module Node.Fastify.Reply where

import Prelude

import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Effect (Effect)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Foreign.Object (Object)
import Node.Fastify.Handler (HandlerM(..), Handler)
import Node.Fastify.Types (FastifyReply, FastifyRequest)

foreign import _code :: Fn2 FastifyReply Number ( Effect Unit )

code :: Number -> Handler
code statusCode = HandlerM \_ reply ->
  liftEffect $ runFn2 _code reply statusCode

foreign import _status :: Fn2 FastifyReply Number ( Effect Unit )

status :: Number -> Handler
status statusCode = HandlerM \_ reply ->
  liftEffect $ runFn2 _status reply statusCode

foreign import _header :: Fn3 FastifyReply String String ( Effect Unit )

header :: String -> String -> Handler
header name value = HandlerM \_ reply ->
  liftEffect $ runFn3 _header reply name value

foreign import _headers :: Fn2 FastifyReply ( Object Foreign ) ( Effect Unit )

headers :: Object Foreign -> Handler
headers values = HandlerM \_ reply ->
  liftEffect $ runFn2 _headers reply values

foreign import _getHeader :: Fn2 FastifyReply String ( Effect String )

getHeader :: String -> HandlerM String
getHeader name = HandlerM \_ reply ->
  liftEffect $ runFn2 _getHeader reply name

foreign import _getHeaders :: FastifyReply -> ( Effect Foreign )

getHeaders :: HandlerM Foreign
getHeaders = HandlerM \_ reply ->
  liftEffect $ _getHeaders reply

foreign import _removeHeader :: Fn2 FastifyReply String ( Effect Unit )

removeHeader :: String -> HandlerM Unit
removeHeader key = HandlerM \_ reply ->
  liftEffect $ runFn2 _removeHeader reply key

foreign import _hasHeader :: Fn2 FastifyReply String ( Effect Boolean )

hasHeader :: String -> HandlerM Boolean
hasHeader name = HandlerM \_ reply ->
  liftEffect $ runFn2 _hasHeader reply name

foreign import _type :: Fn2 FastifyReply String ( Effect Unit )

type_ :: String -> Handler
type_ value = HandlerM \_ reply ->
  liftEffect $ runFn2 _type reply value

foreign import _redirect :: Fn2 FastifyReply String ( Effect Unit )

redirect :: String -> Handler
redirect dest = HandlerM \_ reply ->
  liftEffect $ runFn2 _redirect reply dest

foreign import _redirectWithCode :: Fn3 FastifyReply Number String ( Effect Unit )

redirectWithCode :: Number -> String -> Handler
redirectWithCode statusCode dest = HandlerM \_ reply ->
  liftEffect $ runFn3 _redirectWithCode reply statusCode dest

foreign import _send :: Fn2 FastifyReply String ( Effect Unit )

send :: String -> Handler
send payload = HandlerM \_ rep ->
  liftEffect $ runFn2 _send rep payload

foreign import _request :: FastifyReply -> Effect FastifyRequest

request :: HandlerM FastifyRequest
request = HandlerM \_ reply ->
  liftEffect $ _request reply

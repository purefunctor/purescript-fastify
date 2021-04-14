module Node.Fastify.Reply where

import Prelude

import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Effect (Effect)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Foreign.Object (Object)
import Node.Fastify.Handler (HandlerM(..))
import Node.Fastify.Types (Reply, Request)

foreign import _code :: Fn2 Reply Number ( Effect Reply )

code :: Number -> HandlerM Reply
code statusCode = HandlerM \_ reply ->
  liftEffect $ runFn2 _code reply statusCode

foreign import _status :: Fn2 Reply Number ( Effect Reply )

status :: Number -> HandlerM Reply
status statusCode = HandlerM \_ reply ->
  liftEffect $ runFn2 _status reply statusCode

foreign import _header :: Fn3 Reply String String ( Effect Reply )

header :: String -> String -> HandlerM Reply
header name value = HandlerM \_ reply ->
  liftEffect $ runFn3 _header reply name value

foreign import _headers :: Fn2 Reply ( Object Foreign ) ( Effect Reply )

headers :: Object Foreign -> HandlerM Reply
headers values = HandlerM \_ reply ->
  liftEffect $ runFn2 _headers reply values

foreign import _getHeader :: Fn2 Reply String ( Effect String )

getHeader :: String -> HandlerM String
getHeader name = HandlerM \_ reply ->
  liftEffect $ runFn2 _getHeader reply name

foreign import _getHeaders :: Reply -> ( Effect Foreign )

getHeaders :: HandlerM Foreign
getHeaders = HandlerM \_ reply ->
  liftEffect $ _getHeaders reply

foreign import _removeHeader :: Fn2 Reply String ( Effect Unit )

removeHeader :: String -> HandlerM Unit
removeHeader key = HandlerM \_ reply ->
  liftEffect $ runFn2 _removeHeader reply key

foreign import _hasHeader :: Fn2 Reply String ( Effect Boolean )

hasHeader :: String -> HandlerM Boolean
hasHeader name = HandlerM \_ reply ->
  liftEffect $ runFn2 _hasHeader reply name

foreign import _type :: Fn2 Reply String ( Effect Reply )

type_ :: String -> HandlerM Reply
type_ value = HandlerM \_ reply ->
  liftEffect $ runFn2 _type reply value

foreign import _redirect :: Fn2 Reply String ( Effect Reply )

redirect :: String -> HandlerM Reply
redirect dest = HandlerM \_ reply ->
  liftEffect $ runFn2 _redirect reply dest

foreign import _redirectWithCode :: Fn3 Reply Number String ( Effect Reply )

redirectWithCode :: Number -> String -> HandlerM Reply
redirectWithCode statusCode dest = HandlerM \_ reply ->
  liftEffect $ runFn3 _redirectWithCode reply statusCode dest

foreign import _send :: Fn2 Reply String ( Effect Reply )

send :: String -> HandlerM Reply
send payload = HandlerM \_ rep ->
  liftEffect $ runFn2 _send rep payload

foreign import _request :: Reply -> Effect Request

request :: HandlerM Request
request = HandlerM \_ reply ->
  liftEffect $ _request reply

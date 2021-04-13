module Node.Fastify.Reply where

import Prelude

import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Effect (Effect)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Foreign.Object (Object)
import Node.Fastify.Handler (HandlerM)
import Node.Fastify.Types (Reply, Request)

foreign import _code :: Fn2 Reply Number ( Effect Reply )

code :: Reply -> Number -> HandlerM Reply
code reply statusCode = liftEffect $ runFn2 _code reply statusCode

foreign import _status :: Fn2 Reply Number ( Effect Reply )

status :: Reply -> Number -> HandlerM Reply
status reply statusCode = liftEffect $ runFn2 _status reply statusCode

foreign import _header :: Fn3 Reply String String ( Effect Reply )

header :: Reply -> String -> String -> HandlerM Reply
header reply name value = liftEffect $ runFn3 _header reply name value

foreign import _headers :: Fn2 Reply ( Object Foreign ) ( Effect Reply )

headers :: Reply -> Object Foreign -> HandlerM Reply
headers reply values = liftEffect $ runFn2 _headers reply values

foreign import _getHeader :: Fn2 Reply String ( Effect String )

getHeader :: Reply -> String -> HandlerM String
getHeader reply name = liftEffect $ runFn2 _getHeader reply name

foreign import _getHeaders :: Reply -> ( Effect Foreign )

getHeaders :: Reply -> HandlerM Foreign
getHeaders = liftEffect <<< _getHeaders

foreign import _removeHeader :: Fn2 Reply String ( Effect Unit )

removeHeader :: Reply -> String -> HandlerM Unit
removeHeader reply key = liftEffect $ runFn2 _removeHeader reply key

foreign import _hasHeader :: Fn2 Reply String ( Effect Boolean )

hasHeader :: Reply -> String -> HandlerM Boolean
hasHeader reply name = liftEffect $ runFn2 _hasHeader reply name

foreign import _type :: Fn2 Reply String ( Effect Reply )

type_ :: Reply -> String -> HandlerM Reply
type_ reply value = liftEffect $ runFn2 _type reply value

foreign import _redirect :: Fn2 Reply String ( Effect Reply )

redirect :: Reply -> String -> HandlerM Reply
redirect reply dest = liftEffect $ runFn2 _redirect reply dest

foreign import _redirectWithCode :: Fn3 Reply Number String ( Effect Reply )

redirectWithCode :: Reply -> Number -> String -> HandlerM Reply
redirectWithCode reply statusCode dest =
  liftEffect $ runFn3 _redirectWithCode reply statusCode dest

foreign import _send :: Fn2 Reply Foreign ( Effect Reply )

send :: Reply -> Foreign -> HandlerM Reply
send reply payload = liftEffect $ runFn2 _send reply payload

foreign import _request :: Reply -> Effect Request

request :: Reply -> HandlerM Request
request = liftEffect <<< _request

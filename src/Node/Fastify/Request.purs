module Node.Fastify.Request where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Foreign.Object (Object)
import Node.Fastify.Handler (HandlerM(..))
import Node.Fastify.Types (Request)

foreign import _getBody :: Request -> Effect ( Object Foreign )

getBody :: HandlerM (Object Foreign)
getBody = HandlerM \req _ ->
  liftEffect $ _getBody req

foreign import _getQuery :: Request -> Effect ( Object Foreign )

getQuery :: HandlerM (Object Foreign)
getQuery = HandlerM \req _ ->
  liftEffect $ _getQuery req

foreign import _getHeaders :: Request -> Effect ( Object Foreign )

getHeaders :: HandlerM (Object Foreign)
getHeaders = HandlerM \req _ ->
  liftEffect $ _getHeaders req

foreign import _getParams :: Request -> Effect ( Object Foreign )

getParams :: HandlerM (Object Foreign)
getParams = HandlerM \req _ ->
  liftEffect $ _getParams req

foreign import _getId :: Request -> Effect String

getId :: HandlerM String
getId = HandlerM \req _ -> do
  liftEffect $ _getId req

foreign import _getIp :: Request -> Effect String

getIp :: HandlerM String
getIp = HandlerM \req _ -> do
  liftEffect $ _getIp req

foreign import _getHostname :: Request -> Effect String

getHostname :: HandlerM String
getHostname = HandlerM \req _ -> do
  liftEffect $ _getHostname req

foreign import _getProtocol :: Request -> Effect String

getProtocol :: HandlerM String
getProtocol = HandlerM \req _ -> do
  liftEffect $ _getProtocol req

foreign import _getMethod :: Request -> Effect String

getMethod :: HandlerM String
getMethod = HandlerM \req _ -> do
  liftEffect $ _getMethod req

foreign import _getUrl :: Request -> Effect String

getUrl :: HandlerM String
getUrl = HandlerM \req _ -> do
  liftEffect $ _getUrl req

foreign import _getRouterMethod :: Request -> Effect String

getRouterMethod :: HandlerM String
getRouterMethod = HandlerM \req _ -> do
  liftEffect $ _getRouterMethod req

foreign import _getRouterPath :: Request -> Effect String

getRouterPath :: HandlerM String
getRouterPath = HandlerM \req _ -> do
  liftEffect $ _getRouterPath req

foreign import _getIs404 :: Request -> Effect Boolean

getIs404 :: HandlerM Boolean
getIs404 = HandlerM \req _ -> do
  liftEffect $ _getIs404 req

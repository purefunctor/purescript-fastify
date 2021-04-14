module Node.Fastify.Handler where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Node.Fastify.Types (Reply, Request)

-- | Monad used for handling requests.
newtype HandlerM r = HandlerM ( Request -> Reply -> Aff r )

type Handler = HandlerM Unit

instance functorHandleM :: Functor ( HandlerM ) where
  map f ( HandlerM h ) = HandlerM \req rep -> f <$> h req rep

instance applyHandlerM :: Apply ( HandlerM ) where
  apply ( HandlerM f ) ( HandlerM h ) = HandlerM \req rep -> do
    f' <- f req rep
    h' <- h req rep
    pure $ f' h'

instance applicativeHandlerM :: Applicative HandlerM where
  pure r = HandlerM \_ _ -> pure r

instance bindHandlerM :: Bind HandlerM where
  bind ( HandlerM h ) f = HandlerM \req rep -> do
    ( HandlerM g ) <- liftM1 f $ h req rep
    g req rep

instance monadHandlerM :: Monad HandlerM

instance monadEffectHandlerM :: MonadEffect HandlerM where
  liftEffect h = HandlerM \_ _ -> liftEffect h

instance monadAffHandlerM :: MonadAff HandlerM where
  liftAff h = HandlerM \_ _ -> h

runHandler :: Handler -> ( Request -> Reply -> Effect Unit )
runHandler ( HandlerM h ) req res = runAff_ (\_ -> pure unit) ( h req res )

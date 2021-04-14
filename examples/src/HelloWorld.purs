module HelloWorld where

import Prelude

import Effect (Effect)
import Effect.Console as Console
import Node.Fastify.Reply (send, type_)
import Node.Fastify.Server (Server, get, listen)

server :: Server
server = do
  get "/" do
    void $ type_ "text/html"
    void $ send "Hello, World!"

main :: Effect Unit
main = do
  Console.log "Listening: http://localhost:3000"
  listen server 3000

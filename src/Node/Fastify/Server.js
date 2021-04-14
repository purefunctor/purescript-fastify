"use strict";

const fastify = require("fastify");

exports._mkServer = function(options) {
  return function() {
    return fastify(options);
  };
};

exports._http = function(server, method, route, handler) {
  return function () {
    server[method](route, function(req, rep) {
      handler(req)(rep)();
    });
  };
};

exports._listen = function(server, port) {
  return function () {
    server.listen(port, function(err, add) {

    });
  };
};

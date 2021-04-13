"use strict";

const fastify = require("fastify");

exports._mkServer = function(options) {
  return function() {
    return fastify(options);
  };
};

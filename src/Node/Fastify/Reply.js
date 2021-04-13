"use strict";

exports._code = function(reply, statusCode) {
  return function() {
    return reply.code(statusCode);
  };
};

exports._status = exports._code

exports._header = function(reply, name, value) {
  return function() {
    return reply.header(name, value);
  };
};

exports._headers = function(reply, object) {
  return function() {
    return reply.headers(object);
  };
};

exports._getHeader = function(reply, name) {
  return function() {
    return reply.getHeader(name);
  };
};

exports._getHeaders = function(reply) {
  return function() {
    return reply.getHeaders();
  };
};

exports._removeHeader = function(reply, key) {
  return function() {
    return reply.removeHeader(key);
  };
};


exports._hasHeader = function(reply, name) {
  return function() {
    return reply.hasHeader(name);
  };
};

exports._type = function(reply, value) {
  return function() {
    return reply.type(value);
  };
};

exports._redirect = function(reply, dest) {
  return function() {
    return reply.redirect(dest);
  };
};

exports._redirectWithCode = function(reply, code, dest) {
  return function() {
    return reply.redirect(code, dest);
  };
};

exports._send = function(reply, payload) {
  return function() {
    return reply.send(payload);
  };
};

exports._request = function(reply) {
  return function() {
    return reply.request;
  };
};

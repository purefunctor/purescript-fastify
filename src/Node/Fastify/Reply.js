"use strict";

exports._code = function(reply, statusCode) {
  return function() {
    reply.code(statusCode);
  };
};

exports._status = exports._code

exports._header = function(reply, name, value) {
  return function() {
    reply.header(name, value);
  };
};

exports._headers = function(reply, object) {
  return function() {
    reply.headers(object);
  };
};

exports._getHeader = function(reply, name) {
  return function() {
    reply.getHeader(name);
  };
};

exports._getHeaders = function(reply) {
  return function() {
    reply.getHeaders();
  };
};

exports._removeHeader = function(reply, key) {
  return function() {
    reply.removeHeader(key);
  };
};


exports._hasHeader = function(reply, name) {
  return function() {
    reply.hasHeader(name);
  };
};

exports._type = function(reply, value) {
  return function() {
    reply.type(value);
  };
};

exports._redirect = function(reply, dest) {
  return function() {
    reply.redirect(dest);
  };
};

exports._redirectWithCode = function(reply, code, dest) {
  return function() {
    reply.redirect(code, dest);
  };
};

exports._send = function(reply, payload) {
  return function() {
    reply.send(payload);
  };
};

exports._request = function(reply) {
  return function() {
    reply.request;
  };
};

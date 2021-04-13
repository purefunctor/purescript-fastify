"use strict";

exports._getBody = function (request) {
  return function() {
    return request.body;
  };
};

exports._getQuery = function (request) {
  return function() {
    return request.query;
  };
};

exports._getParams = function (request) {
  return function() {
    return request.params;
  };
};

exports._getHeaders = function (request) {
  return function() {
    return request.headers;
  };
};

exports._getId = function (request) {
  return function() {
    return request.id;
  };
};

exports._getId = function (request) {
  return function() {
    return request.id;
  };
};

exports._getIp = function (request) {
  return function() {
    return request.ip;
  };
};

exports._getHostname = function (request) {
  return function() {
    return request.hostname;
  };
};

exports._getProtocol = function (request) {
  return function() {
    return request.protocol;
  };
};

exports._getMethod = function (request) {
  return function() {
    return request.method;
  };
};

exports._getUrl = function (request) {
  return function() {
    return request.url;
  };
};

exports._getRouterMethod = function (request) {
  return function() {
    return request.routerMethod;
  };
};

exports._getRouterPath = function (request) {
  return function() {
    return request.routerPath;
  };
};

exports._getIs404 = function (request) {
  return function() {
    return request.is404;
  };
};

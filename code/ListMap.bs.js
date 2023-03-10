// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Belt_List = require("rescript/lib/js/belt_List.js");

function remove(map, k) {
  return Belt_List.keep(map, (function (param) {
                return param[0] !== k;
              }));
}

function set(map, k, v) {
  return {
          hd: [
            k,
            v
          ],
          tl: remove(map, k)
        };
}

function get(_map, k) {
  while(true) {
    var map = _map;
    if (!map) {
      return ;
    }
    var match = map.hd;
    if (match[0] === k) {
      return match[1];
    }
    _map = map.tl;
    continue ;
  };
}

var ListMap = {
  empty: /* [] */0,
  remove: remove,
  set: set,
  get: get,
  size: Belt_List.size
};

exports.ListMap = ListMap;
/* No side effect */

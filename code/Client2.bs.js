// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';


var submit = document.getElementById("submit");

var result = document.getElementById("result");

var input = document.getElementById("name");

submit.addEventListener("click", (function (param) {
        var payload = {
          method: "POST",
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
                name: input.value
              })
        };
        var __x = fetch("/hello", payload);
        var __x$1 = __x.then(function (val) {
              return Promise.resolve(val.json());
            });
        __x$1.then(function (val) {
              return Promise.resolve((result.innerHTML = val.message, undefined));
            });
        
      }));

/* submit Not a pure module */

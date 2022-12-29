// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Path = require("path");
var Express = require("express");

var app = Express();

app.use(Express.json());

app.get("/", (function (param, response) {
        response.sendFile(Path.join(__dirname, "index.html"));
        
      }));

app.get("/script", (function (param, response) {
        response.sendFile(Path.join(__dirname, "Client2.bs.js"));
        
      }));

app.post("/hello", (function (request, response) {
        var body = request.body;
        response.send({
              message: "Hello, " + body.name
            });
        
      }));

app.listen(4000, (function (param) {
        console.log("Server is running on port 4000.");
        
      }));

exports.app = app;
/* app Not a pure module */

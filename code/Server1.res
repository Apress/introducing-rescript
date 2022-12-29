@val external express: 'a = "express"
@val external path: 'a = "path"

%%raw(`
var express = require('express');
var path = require('path');
`)

let app = express(.)

app["use"](. express["json"](.))

app["get"](."/", (. _, response) => {
  response["sendFile"](. path["join"](. %raw(`__dirname`), "index.html"))
})

app["get"](."/script", (. _, response) => {
  response["sendFile"](. path["join"](. %raw(`__dirname`), "Client1.bs.js"))
})

app["post"](."/hello", (. request, response) => {
  response["send"](. {
    "message": "Hello, " ++ request["body"]["name"],
  })
})

app["listen"](.4000, () => {
  Js.log("Server is running on port 4000.")
})

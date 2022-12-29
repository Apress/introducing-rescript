type app
type middleware
type request
type response

@module external express: unit => app = "express"
@module("express") external json: unit => middleware = "json"

@send external use: (app, middleware) => unit = "use"
@send external get: (app, string, (request, response) => unit) => unit = "get"
@send external post: (app, string, (request, response) => unit) => unit = "post"
@send external listen: (app, int, unit => unit) => unit = "listen"

@get external getBody: request => 'a = "body"

@send external sendFile: (response, string) => unit = "sendFile"
@send external send: (response, 'a) => unit = "send"

@val external dirname: string = "__dirname"

@module("path") @variadic
external join: array<string> => string = "join"

let app = express()

app->use(json())

app->get("/", (_, response) => {
  response->sendFile(join([dirname, "index.html"]))
})

app->get("/script", (_, response) => {
  response->sendFile(join([dirname, "Client2.bs.js"]))
})

app->post("/hello", (request, response) => {
  let body = request->getBody
  response->send({
    "message": "Hello, " ++ body["name"],
  })
})

app->listen(4000, () => {
  Js.log("Server is running on port 4000.")
})

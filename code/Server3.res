let {
  expressCjs: express,
  jsonMiddleware: json,
  listenWithCallback: listen,
  use,
  get,
  post,
  body,
  sendFile,
  send,
} = module(Express)

let app = express()

app->use(json())

app->get("/", (_, response) => {
  open NodeJs
  response->sendFile(Path.join([Global.dirname, "index.html"]))->ignore
})

app->get("/script", (_, response) => {
  open NodeJs
  response->sendFile(Path.join([Global.dirname, "Client3.bs.js"]))->ignore
})

app->post("/hello", (request, response) => {
  let body = request->body
  response
  ->send({
    "message": "Hello, " ++ body["name"],
  })
  ->ignore
})

let _ = app->listen(4000, _ => {
  Js.log("Server is running on port 4000.")
})

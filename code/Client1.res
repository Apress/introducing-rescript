@val external document: 'a = "document"
@val external fetch: 'a = "fetch"

let submit = document["getElementById"](. "submit")
let result = document["getElementById"](. "result")
let input = document["getElementById"](. "name")

submit["addEventListener"](. "click", _ => {
  let payload = {
    "method": "POST",
    "headers": {
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    "body": Js.Json.stringifyAny({
      "name": input["value"],
    }),
  }
  open Js.Promise
  fetch(. "/hello", payload)
  ->then_(val => Js.Promise.resolve(val["json"](.)), _)
  ->then_(val => {
    result["innerHTML"] = val["message"]
    resolve()
  }, _)
  ->ignore
})

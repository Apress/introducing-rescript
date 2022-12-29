@val external document: Dom.document = "document"
@send external getElementById: (Dom.document, string) => Dom.element = "getElementById"

@send external addEventListener: (Dom.element, string, unit => unit) => unit = "addEventListener"
@get external value: Dom.element => string = "value"
@set external innerHTML: (Dom.element, string) => unit = "innerHTML"

type response
@val external fetch: (string, 'a) => Js.Promise.t<response> = "fetch"
@send external json: response => 'a = "json"

let submit = document->getElementById("submit")
let result = document->getElementById("result")
let input = document->getElementById("name")

submit->addEventListener("click", _ => {
  let payload = {
    "method": "POST",
    "headers": {
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    "body": Js.Json.stringifyAny({
      "name": input->value,
    }),
  }
  open Js.Promise
  fetch("/hello", payload)->then_(val => resolve(val->json), _)->then_(val => {
    result->innerHTML(val["message"])->resolve
  }, _)->ignore
})

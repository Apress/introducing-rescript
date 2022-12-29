let {document} = module(Webapi.Dom)
let {getExn, flatMap} = module(Belt.Option)
let {getElementById} = module(Webapi.Dom.Document)
let {addEventListener, setInnerHTML} = module(Webapi.Dom.Element)
module HtmlInputElement = Webapi.Dom.HtmlInputElement

let submit = document->getElementById("submit")->getExn
let result = document->getElementById("result")->getExn
let input = document->getElementById("name")->flatMap(HtmlInputElement.ofElement)->getExn

submit->addEventListener("click", _ => {
  open Webapi.Fetch
  let payload = RequestInit.make(
    ~method_=Post,
    ~headers=HeadersInit.make({
      "Accept": "application/json",
      "Content-Type": "application/json",
    }),
    ~body=BodyInit.make(
      Js.Json.stringifyAny({
        "name": input->HtmlInputElement.value,
      })->getExn,
    ),
    (),
  )
  Js.log(payload)
  open Js.Promise
  fetchWithInit("/hello", payload)
  ->then_(Response.json, _)
  ->then_(json => json->Js.Json.decodeObject->getExn->resolve, _)
  ->then_(obj => {
    let message = Js.Dict.get(obj, "message")->flatMap(Js.Json.decodeString)->getExn
    result->setInnerHTML(message)
    resolve()
  }, _)
  ->ignore
})
// @scope("JSON") @val
// external parse: string => 'a = "parse"

// let parsed = parse(`{ "player": 1, "score": 200}`)
// let x: string = parsed["hello"]

// type player = {
//     "player": int,
//     "score": int,
// }

// @scope("JSON") @val
// external parsePlayer: string => player = "parse"

// let parsed = parsePlayer(`{ "player": 1, "score": 200}`)
// Js.log(parsed["hello"])

open Belt.Option

type player = {"player": int, "score": int}

let parsePlayer = s => {
  let parsed = Js.Json.parseExn(s)
  let obj = Js.Json.decodeObject(parsed)->Belt.Option.getExn
  let player = obj->Js.Dict.get("player")->flatMap(Js.Json.decodeNumber)->getExn->Belt.Float.toInt
  let score = obj->Js.Dict.get("score")->flatMap(Js.Json.decodeNumber)->getExn->Belt.Float.toInt
  {
    "player": player,
    "score": score,
  }
}

open Belt.Option
let parsePlayer2 = s => {
  try {
    let parsed = Js.Json.parseExn(s)
    let obj = Js.Json.decodeObject(parsed)->Belt.Option.getExn
    let player = obj->Js.Dict.get("player")->flatMap(Js.Json.decodeNumber)->getExn->Belt.Float.toInt
    let score = obj->Js.Dict.get("score")->flatMap(Js.Json.decodeNumber)->getExn->Belt.Float.toInt
    Some({
      "player": player,
      "score": score,
    })
  } catch {
  | _ => None
  }
}

let parsed = parsePlayer2(`{ "player": 1}`)
switch parsed {
| Some(_) => Js.log("we parsed it")
| _ => Js.log("failed to parse")
}

open Belt.Option
let parsePlayer3 = s => {
  let parsed = try {Js.Json.parseExn(s)} catch {
  | _ => failwith("could not parse")
  }
  let obj = try {
    Js.Json.decodeObject(parsed)->Belt.Option.getExn
  } catch {
  | _ => failwith("expected object")
  }
  let player = try {
    obj->Js.Dict.get("player")->flatMap(Js.Json.decodeNumber)->getExn->Belt.Float.toInt
  } catch {
  | _ => failwith("expected player:int")
  }

  let score = try {
    obj->Js.Dict.get("score")->flatMap(Js.Json.decodeNumber)->getExn->Belt.Float.toInt
  } catch {
  | _ => failwith("expected score:int")
  }
  {
    "player": player,
    "score": score,
  }
}

let parsed = parsePlayer(`{ "player": 1}`)

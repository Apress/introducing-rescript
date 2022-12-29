type catObj = {"name": string, "age": int, "owner": string}
let myCat: catObj = {"name": "Creamsicle", "age": 13, "owner": "Danny"}

let serialized = Js.Json.serializeExn(myCat)

// prints '{ "name": "Creamsicle", "age": 13, "owner": "Danny" }'
Js.log(serialized)

@scope("JSON") @val
external parseCat: string => catObj = "parse"

let parsed = parseCat(`{ "name": "Creamsicle", "age": 13, "owner": "Danny" }`)

// prints Creamsicle
Js.log(parsed["name"])

let c = {"x": 1, "y": 1}
let c' = Js.Obj.assign(c, {"z": 2})

// prints { "x": 1, "y": 1, "z": 2}
Js.log(c)

// prints { "x": 1, "y": 2, "z": 2}
Js.log(c')

type coord = {"x": int, "y": int}

let manhattan = (obj: coord) => {
  abs(obj["x"]) + abs(obj["y"])
}

@scope("JSON") @val
external parseAny: string => 'a = "parse"
let parsed = parseAny(`{ "name": "Creamsicle", "age": 13, "owner": "Danny" }`)
let name:string = parsed["name"]


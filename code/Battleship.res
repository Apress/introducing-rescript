open Belt

module CoordCmp = Id.MakeComparable({
  type t = (int, int)
  let cmp = (a, b) => Pervasives.compare(a, b)
})

let guessed = Set.fromArray([(1, 1)], ~id=module(CoordCmp))
let ships = Set.fromArray([(2, 2), (2, 3), (2, 4)], ~id=module(CoordCmp))

let checkCoord = ((x, y) as coord, guesses, ships) => {
  if Set.has(guesses, coord) {
    Js.log("already guessed")
  } else if Set.has(ships, coord) {
    Js.log("hit")
  } else {
    Js.log("miss")
  }
}

checkCoord((1, 1), guessed, ships)
checkCoord((0, 0), guessed, ships)
checkCoord((2, 2), guessed, ships)
checkCoord((-1, 0), guessed, ships)

type grid = Ship | Guessed

let board = Map.fromArray(
  [((2, 2), Ship), ((2, 3), Ship), ((2, 4), Ship), ((1, 1), Guessed)],
  ~id=module(CoordCmp),
)

let checkCoord = ((x, y) as coord, map) => {
  switch Map.get(map, coord) {
  | Some(Guessed) => Js.log("already guessed")
  | Some(Ship) => Js.log("hit")
  | None => Js.log("miss")
  }
}

checkCoord((1, 1), board)
checkCoord((0, 0), board)
checkCoord((2, 2), board)
checkCoord((-1, 0), board)

type color = Black | White
type position = (int, int)

type pieceType = Pawn | Bishop | Knight | Rook | Queen | King

let firstPlayerColor: color = White
let myKing: pieceType = King

let points = (t: pieceType) => {
  switch t {
  | Pawn => 1
  | Knight
  | Bishop => 3
  | Rook => 5
  | Queen => 9
  | King => 0
  }
}

points(Rook)->Js.log
points(Queen)->Js.log

let startingRank = (t: pieceType, c: color) => {
  switch (t, c) {
  | (Pawn, Black) => 7
  | (_, Black) => 8
  | (Pawn, White) => 1
  | (_, White) => 0
  }
}

startingRank(Pawn, Black)->Js.log
startingRank(Rook, Black)->Js.log

// tuples

type chessPiece =
  | Pawn(color, position, bool)
  | Knight(color, position)
  | Bishop(color, position)
  | Queen(color, position)
  | Rook(color, position, bool)
  | King(color, position, bool, bool)

let points = (piece: chessPiece) => {
  switch piece {
  | Pawn(_) => 1
  | Knight(_)
  | Bishop(_) => 3
  | Rook(_) => 5
  | Queen(_) => 9
  | King(_) => 0
  }
}

points(Rook(White, (1, 1), false))->Js.log
points(Queen(White, (1, 4)))->Js.log

let color = piece => {
  switch piece {
  | Pawn(color, _, _)
  | Knight(color, _)
  | Bishop(color, _)
  | Rook(color, _, _)
  | Queen(color, _)
  | King(color, _, _, _) => color
  }
}

let whiteBishop = Bishop(White, (1, 3))
let whiteKnight = Knight(White, (1, 2))
let blackRook = Rook(Black, (8, 1), true)
Js.log(whiteBishop->color === whiteKnight->color)
Js.log(whiteKnight->color !== blackRook->color)

let canCapture = (attacker: chessPiece, target: chessPiece) => {
  switch (attacker, target) {
  | (_, King(_)) => false
  | _ => color(attacker) !== color(target)
  }
}

let whiteBishop = Bishop(White, (1, 3))
let whiteKnight = Knight(White, (2, 4))
let whiteKing = King(White, (8, 2), false, false)
let blackRook = Rook(Black, (8, 3), false)

// can capture
Js.log(canCapture(blackRook, whiteBishop))
Js.log(canCapture(whiteKing, blackRook))

// cannot capture
Js.log(canCapture(blackRook, whiteKing))
Js.log(canCapture(whiteBishop, whiteKnight))

let canCastle = (moving: chessPiece, target: chessPiece) => {
  switch (moving, target) {
  | (Rook(c1, _, false), King(c2, _, false, false))
  | (King(c1, _, false, false), Rook(c2, _, false)) =>
    c1 === c2
  | _ => false
  }
}

let whiteKing = King(White, (1, 5), false, false)
let whiteRook1 = Rook(White, (1, 1), false)
let whiteRook2 = Rook(White, (1, 6), true)

// this is allowed
Js.log(canCastle(whiteKing, whiteRook1)) 
// this is not allowed, the rook has moved
Js.log(canCastle(whiteKing, whiteRook2)) 


let canRookMove = (c: color, target: chessPiece) => {
  switch target {
  | King(kingColor, _, false, false) => kingColor === c
  | _ => color(target) !== c
  }
}

let canRookMove = (c: color, target: option<chessPiece>) => {
  switch target {
  | None => true
  | Some(King(kingColor, _, false, false)) => kingColor === c
  | Some(piece) => color(piece) !== c
  }
}

let rook: chessPiece = Rook(White, (1, 1), false)
// let rook: chessPiece = Rook(White, (1, 1))

// records

type chessPieceRecord =
  | Pawn({color: color, pos: position, hasMoved: bool})
  | Knight({color: color, pos: position})
  | Bishop({color: color, pos: position})
  | Queen({color: color, pos: position})
  | Rook({color: color, pos: position, hasMoved: bool})
  | King({color: color, pos: position, hasMoved: bool, inCheck: bool})

let rook: chessPieceRecord = Rook({color: White, pos: (1, 1), hasMoved: false})

let color = piece => {
  switch piece {
  | Pawn({color})
  | Knight({color})
  | Bishop({color})
  | Rook({color})
  | Queen({color})
  | King({color}) => color
  }
}

let canCastle = (moving: chessPieceRecord, target: chessPieceRecord) => {
  switch (moving, target) {
  | (Rook({color: c1, hasMoved: false}), King({color: c2, hasMoved: false, inCheck: false}))
  | (King({color: c1, hasMoved: false, inCheck: false}), Rook({color: c2, hasMoved: false})) =>
    c1 === c2
  | _ => false
  }
}


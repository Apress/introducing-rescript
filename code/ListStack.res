type t<'a> = list<'a>

let new = () => list{}

let push = (stack, element) => {
  list{element, ...stack}
}

let peek = stack => {
  switch stack {
  | list{hd, ..._} => Some(hd)
  | _ => None
  }
}

let pop = stack => {
  switch stack {
  | list{_, ...tl} => tl
  | _ => stack
  }
}

let size = Belt.List.size

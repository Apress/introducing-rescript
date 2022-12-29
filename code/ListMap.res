module type MapSig = {
  type t<'a>
  let empty: t<'a>
  let set: (t<'a>, string, 'a) => t<'a>
  let get: (t<'a>, string) => option<'a>
  let remove: (t<'a>, string) => t<'a>
  let size: t<'a> => int
}

module ListMap = {
  type t<'a> = list<(string, 'a)>
  let empty = list{}
  let remove = (map, k) => {
    Belt.List.keep(map, ((key, _)) => key !== k)
  }
  let set = (map, k, v) => {
    list{(k, v), ...remove(map, k)}
  }
  let rec get = (map, k) => {
    switch map {
    | list{} => None
    | list{(key, val), ..._} if key === k => val
    | list{_, ...rest} => get(rest, k)
    }
  }
  let size = Belt.List.size
}

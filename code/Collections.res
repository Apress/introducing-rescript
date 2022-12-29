open Belt

module IntCmp = Id.MakeComparable({
  type t = int
  let cmp = (a, b) => {
    if a < b {
      -1
    } else if a > b {
      1
    } else {
      0
    }
  }
})

let intSet = Set.fromArray([1, 2, 3, 4, 4], ~id=module(IntCmp))
Js.log(Set.toArray(intSet))

module RevIntCmp = Id.MakeComparable({
  type t = int
  let cmp = (a, b) => {
    if a < b {
      1
    } else if a > b {
      -1
    } else {
      0
    }
  }
})

let revIntSet = Set.fromArray([1, 2, 3, 4, 4], ~id=module(RevIntCmp))
Js.log(Set.toArray(revIntSet))

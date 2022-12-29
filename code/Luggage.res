let luggage = [("Seth", 60), ("Sarah", 47), ("Sarah", 40), ("John", 12), ("John", 330)]

// luggage <=50 lb is $25
// luggage >50 and <=100 lb is $50 each
// luggage >100lb is $100

// calculate luggage cost
let pricedLuggage = Js.Array2.map(luggage, ((owner, weight)) => {
  let cost = if weight <= 50 {
    25
  } else if weight <= 100 {
    50
  } else {
    100
  }
  (owner, weight, cost)
})

Js.log(pricedLuggage)

// filter out overweight luggage

let filteredLuggage = Js.Array2.filter(pricedLuggage, ((_, weight, _)) => {
  weight <= 200
})

Js.log(filteredLuggage)

// use reduce to calculate the cost and weight total
let totalWeight = Js.Array2.reduce(
  filteredLuggage,
  (total, (_, weight, _)) => {
    total + weight
  },
  0,
)
Js.log(totalWeight)

let totalCost = Js.Array2.reduce(
  filteredLuggage,
  (total, (_, _, cost)) => {
    total + cost
  },
  0,
)
Js.log(totalCost)

let (totalWeight, totalCost) = Js.Array2.reduce(
  filteredLuggage,
  ((totalWt, totalCst), (_, weight, cost)) => {
    (totalWt + weight, totalCst + cost)
  },
  (0, 0),
)
Js.log2(totalWeight, totalCost)

let processLuggage = (luggage: array<(string, int)>): (int, int) => {
  open Js.Array2
  map(luggage, ((owner, weight)) => {
    let cost = if weight <= 50 {
      25
    } else if weight <= 100 {
      50
    } else {
      100
    }
    (owner, weight, cost)
  })
  ->filter(((_, weight, _)) => weight <= 200)
  ->reduce(((totalWt, totalCst), (_, weight, cost)) => {
    (totalWt + weight, totalCst + cost)
  }, (0, 0))
}

let processLuggageV2 = (luggage: array<(string, int)>): (int, int) => {
  Js.Array2.reduce(
    luggage,
    ((totalWt, totalCst), (_, weight)) => {
      let cost = if weight <= 50 {
        25
      } else if weight <= 100 {
        50
      } else {
        100
      }
      if weight <= 200 {
        (totalWt + weight, totalCst + cost)
      } else {
        (totalWt, totalCst)
      }
    },
    (0, 0),
  )
}

// differences:
// Belt.List instead of Js.Array2
// keep instead of filter
// argument order for reduce in Belt is different than in Js!

let processLuggageList = (luggage: list<(string, int)>): (int, int) => {
  open Belt
  List.map(luggage, ((owner, weight)) => {
    let cost = if weight <= 50 {
      25
    } else if weight <= 100 {
      50
    } else {
      100
    }
    (owner, weight, cost)
  })
  ->List.keep(((_, weight, _)) => weight < 200)
  ->List.reduce((0, 0), ((totalWt, totalCst), (_, weight, cost)) => {
    (totalWt + weight, totalCst + cost)
  })
}

let processLuggageListV2 = (luggage: list<(string, int)>): (int, int) => {
  Belt.List.reduce(luggage, (0, 0), ((totalWt, totalCst), (_, weight)) => {
    let cost = if weight <= 50 {
      25
    } else if weight <= 100 {
      50
    } else {
      100
    }
    if weight <= 200 {
      (totalWt + weight, totalCst + cost)
    } else {
      (totalWt, totalCst)
    }
  })
}

// list vs array

// see luggage.js

// tuples are immutable, so we cannot mutate them

// translate to ReScript
let totalLuggagePerPerson = (luggage: array<(string, int)>): array<(string, int)> => {
  open Js.Array2
  let weights = []
  forEach(luggage, ((person, weight) as item) => {
    if length(weights) == 0 {
      ignore(unshift(weights, item))
    } else {
      let (currPerson, currWeight) = weights[0]
      if currPerson == person {
        weights[0] = (currPerson, currWeight + weight)
      } else {
        ignore(unshift(weights, item))
      }
    }
  })
  weights
}

let totalLuggagePerPerson = (luggage: array<(string, int)>): array<(string, int)> => {
  open Js.Array2
  reduce(
    luggage,
    (weights, (person, weight) as item) => {
      if length(weights) == 0 {
        ignore(unshift(weights, item))
      } else {
        let (currPerson, currWeight) = weights[0]
        if currPerson == person {
          weights[0] = (currPerson, currWeight + weight)
        } else {
          ignore(unshift(weights, item))
        }
      }
      weights
    },
    [],
  )
}

let totalLuggagePerPerson = (luggage: list<(string, int)>): list<(string, int)> => {
  open Belt
  List.reduce(luggage, list{}, (weights, (person, weight) as item) => {
    switch weights {
    | list{(currPerson, currWeight), ...tail} if currPerson == person => list{
        (currPerson, currWeight + weight),
        ...tail,
      }
    | _ => list{item, ...weights}
    }
  })
}

let totalLuggagePerPersonMap = (luggage: array<(string, int)>) => {
  open Belt
  let weights = MutableMap.String.make()
  Array.forEach(luggage, ((person, weight) as item) => {
    let curr = MutableMap.String.getWithDefault(weights, person, 0)
    MutableMap.String.set(weights, person, curr + weight)
  })
  weights
}

let totalLuggagePerPersonMap = (luggage: array<(string, int)>) => {
  open Belt
  Array.reduce(luggage, Map.String.empty, (weights, (person, weight) as item) => {
    let curr = Map.String.getWithDefault(weights, person, 0)
    Map.String.set(weights, person, curr + weight)
  })
}

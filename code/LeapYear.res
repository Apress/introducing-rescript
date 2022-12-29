@val external process: 'a = "process"

let input = process["argv"][2]
let year = input->Belt.Int.fromString->Belt.Option.getExn

let isLeapYear = if mod(year, 400) == 0 {
  true
} else if mod(year, 100) == 0 {
  false
} else if mod(year, 4) == 0 {
  true
} else {
  false
}

if isLeapYear {
  Js.log(`${input} is a leap year`)
} else {
  Js.log(`${input} is not a leap year`)
}

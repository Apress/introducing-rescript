let double = x => x * 2
// the right hand expression evaluates to 800
let n = 100->double->double->double

let rec isEven = x => {
  if x == 0 {
    true
  } else {
    isOdd(abs(x) - 1)
  }
}
and isOdd = x => {
  if x == 0 {
    false
  } else {
    isEven(abs(x) - 1)
  }
}

Js.log(isOdd(100))
Js.log(isEven(20))

Js.log4(1, 2, 3, 4)
Js.log4(1)(2)(3)(4)
Js.log4(1)(2, 3, 4)
Js.log4(1, 2, 3)(4)

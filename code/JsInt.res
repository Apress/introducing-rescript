let add1 = (x: int) => x + 1

%%raw(`

// some large 64 bit number
var x = 1659303064418;
console.log(add1(x));
`)

let add1float = (x: float) => x +. 1.

%%raw(`

// some large 64 bit number
var x = 1659303064418;
console.log(add1float(x));
`)
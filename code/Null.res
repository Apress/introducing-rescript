


// convert null to option
let null: Js.Nullable.t<int> = Js.Nullable.null
let option: option<int> = Js.Nullable.toOption(null)
Js.log(option)

// convert option to nullable
let _ = Js.Nullable.null
let _ = Js.Nullable.undefined
let _ = Js.Nullable.return(1)

let _ = Js.Nullable.fromOption(Some(1))
let _ = Js.Nullable.fromOption(None)

%%raw(`

function testNullable(input) {
    if (input === null) {
        console.log("the value is null");
    } else if (input == undefined) {
        console.log("the value is undefined");
    } else {
        console.log("the value is " + input);
    }
}
`)

@val
external testNullable: Js.Nullable.t<int> => unit = "testNullable"

testNullable(Js.Nullable.null)
testNullable(Js.Nullable.undefined)
testNullable(Js.Nullable.return(1))
testNullable(Js.Nullable.fromOption(Some(1)))
testNullable(Js.Nullable.fromOption(None))
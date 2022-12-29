@module("./js-module")
external getCurrentYear: () => int = "getCurrentYear"

getCurrentYear()->Js.log
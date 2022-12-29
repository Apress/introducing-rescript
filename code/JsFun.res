%%raw(`
var path = require('path');
`)
@val external path: 'a = "path"

let joined = path["join"](. "a", "b")
Js.log(joined)


// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Caml_option = require("rescript/lib/js/caml_option.js");
var Js_null_undefined = require("rescript/lib/js/js_null_undefined.js");

var $$null = null;

var option = ($$null == null) ? undefined : Caml_option.some($$null);

console.log(option);

Js_null_undefined.fromOption(1);

Js_null_undefined.fromOption(undefined);

function testNullable(input) {
    if (input === null) {
        console.log("the value is null");
    } else if (input == undefined) {
        console.log("the value is undefined");
    } else {
        console.log("the value is " + input);
    }
}
;

testNullable(null);

testNullable(undefined);

testNullable(1);

testNullable(Js_null_undefined.fromOption(1));

testNullable(Js_null_undefined.fromOption(undefined));

exports.$$null = $$null;
exports.option = option;
/*  Not a pure module */
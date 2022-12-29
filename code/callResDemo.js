var ListStack = require("./ListStack.bs");

var stack = ListStack.$$new();
var values = [9, 3, 5]

values.forEach(x => {
    stack = ListStack.push(stack, x);
});

while (ListStack.size(stack) !== 0) {
    console.log(ListStack.peek(stack))
    stack = ListStack.pop(stack)
}


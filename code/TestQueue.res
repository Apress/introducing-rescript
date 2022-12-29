open Belt

let stack = MutableStack.make()
MutableStack.push(stack, 1)
MutableStack.push(stack, 2)

Js.log(stack)

MutableStack.forEach(stack, element => Js.log(element))

let q = MutableQueue.make()
MutableQueue.add(q, 1)
MutableQueue.add(q, 2)

Js.log(q)
Js.log(MutableQueue.toArray(q))

let s = MutableStack.make()

MutableStack.push(s, "a")
MutableStack.push(s, "b")
MutableStack.push(s, "c")

MutableStack.forEach(s, element => Js.log(element))
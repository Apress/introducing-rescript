module type ImmStack = {
  type t<'a>
  let new: unit => t<'a>
  let push: (t<'a>, 'a) => t<'a>
  let peek: t<'a> => option<'a>
  let pop: t<'a> => t<'a>
  let size: t<'a> => int
}

module ListStack: ImmStack = {
  // the underlying data type
  type t<'a> = list<'a>

  // initializing a new empty stack
  let new = () => list{}

  // return stack with additional element added
  let push = (stack, element) => {
    list{element, ...stack}
  }

  // return top element of the stack as an option
  let peek = stack => {
    switch stack {
    | list{hd, ..._} => Some(hd)
    | _ => None
    }
  }

  // return stack with top element removed
  let pop = stack => {
    switch stack {
    | list{_, ...tl} => tl
    | _ => stack
    }
  }

  // return number of elements in the stack
  let size = Belt.List.length
}

module ArrayStack: ImmStack = {
  type rec t<'a> = array<'a>

  let new = () => []

  let push = (stack, element) => {
    let copy = stack->Js.Array2.copy
    copy->Js.Array2.push(element)->ignore
    copy
  }

  let peek = stack => {
    if Js.Array2.length(stack) === 0 {
      None
    } else {
      Some(stack[Js.Array2.length(stack) - 1])
    }
  }

  let pop = stack => {
    let copy = stack->Js.Array2.copy
    copy->Js.Array2.pop->ignore
    copy
  }

  let size = Js.Array2.length
}

module MyStack: ImmStack = {
  type rec t<'a> = Empty | Item('a, t<'a>)

  let new = () => Empty

  let push = (stack, element) => {
    Item(element, stack)
  }

  let peek = stack => {
    switch stack {
    | Item(top, _) => Some(top)
    | _ => None
    }
  }

  let pop = stack => {
    switch stack {
    | Item(_, rest) => rest
    | _ => stack
    }
  }

  let rec size = stack => {
    switch stack {
    | Item(_, rest) => 1 + size(rest)
    | _ => 0
    }
  }
}

module type MutStack = {
  type t<'a>
  let new: unit => t<'a>
  let push: (t<'a>, 'a) => unit
  let peek: t<'a> => option<'a>
  let pop: t<'a> => unit
  let size: t<'a> => int
  let copy: t<'a> => t<'a>
}

module MutArrayStack: MutStack = {
  type t<'a> = array<'a>

  let new = () => []

  let push = (stack, element) => {
    stack->Js.Array2.push(element)->ignore
  }

  let peek = stack => {
    let len = Js.Array2.length(stack)
    if len === 0 {
      None
    } else {
      Some(stack[len - 1])
    }
  }

  let pop = stack => {
    stack->Js.Array2.pop->ignore
  }

  let size = Js.Array2.length

  let copy = Js.Array2.copy
}

module MutListStack: MutStack = {
  type t<'a> = ref<ListStack.t<'a>>

  let new = () => ref(ListStack.new())

  let push = (stack, element) => {
    stack := stack.contents->ListStack.push(element)
  }

  let peek = stack => {
    ListStack.peek(stack.contents)
  }

  let pop = stack => {
    stack := ListStack.pop(stack.contents)
  }

  let size = stack => ListStack.size(stack.contents)

  let copy = stack => ref(stack.contents)
}

module MakeMutableStack: ImmStack => MutStack = (Stack: ImmStack) => {
  type t<'a> = ref<Stack.t<'a>>

  let new = () => ref(Stack.new())

  let push = (stack, element) => {
    stack := stack.contents->Stack.push(element)
  }

  let peek = stack => {
    Stack.peek(stack.contents)
  }

  let pop = stack => {
    stack := Stack.pop(stack.contents)
  }

  let size = stack => Stack.size(stack.contents)

  let copy = stack => ref(stack.contents)
}

module MakeImmutableStack: MutStack => ImmStack = (Stack: MutStack) => {
  type t<'a> = Stack.t<'a>

  let new = Stack.new

  let push = (stack, element) => {
    let copy = Stack.copy(stack)
    Stack.push(copy, element)
    copy
  }

  let peek = Stack.peek

  let pop = stack => {
    let copy = Stack.copy(stack)
    Stack.pop(copy)
    copy
  }

  let size = Stack.size
}

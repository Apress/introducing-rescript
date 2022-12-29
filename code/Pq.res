module PriorityQueue = {
  type priority = int
  type rec queue<'a> = Empty | Node(priority, 'a, queue<'a>, queue<'a>)

  let empty = Empty

  let rec insert = (queue, prio, elt) => {
    switch queue {
    | Empty => Node(prio, elt, Empty, Empty)
    | Node(p, e, left, right) =>
      if prio <= p {
        Node(prio, elt, insert(right, p, e), left)
      } else {
        Node(p, e, insert(right, prio, elt), left)
      }
    }
  }

  let rec remove_top = queue => {
    switch queue {
    | Empty => raise(Not_found)
    | Node(_, _, left, Empty) => left
    | Node(_, _, Empty, right) => right
    | Node(_, _, Node(lprio, lelt, _, _) as left, Node(rprio, relt, _, _) as right) =>
      if lprio <= rprio {
        Node(lprio, lelt, remove_top(left), right)
      } else {
        Node(rprio, relt, left, remove_top(right))
      }
    }
  }

  let extract = queue => {
    switch queue {
    | Empty => raise(Not_found)
    | Node(prio, elt, _, _) as queue => (prio, elt, remove_top(queue))
    }
  }
}

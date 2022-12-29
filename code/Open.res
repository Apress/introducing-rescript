open Belt

let double = arr => {
    arr->Array.map(x => x * 2)
}

let myArr = [1, 2, 3]->double
Js.log(myArr[0])
type entity = Player(string, int) | Enemy(int)
type color = White | Black

%%raw(`
function addHealth(entity, n) {
    if (entity.TAG === 0) {
        return {TAG: 0, _0: entity._0, _1: entity._1 + n};
    } else if (entity.TAG === 1) {
        return {TAG: 1, _0: entity._0 + n};
    }
}
`)

@val
external addHealth: (entity, int) => entity = "addHealth"

let entity1 = Player("Danny", 10)
entity1->Js.log
entity1->addHealth(5)->Js.log

let entity2 = Enemy(5)
entity2->Js.log
entity2->addHealth(5)->Js.log

type polyEntity = [ #Player(string, int) | #Enemy(int) ]

let polyEntity1 = #Player("Danny", 10)
let polyEntity2 = #Enemy(5)

let c1 = White
Js.log(c1)

type polyColor = [ #White | #Black ]
let c2 = #White
Js.log(c2)


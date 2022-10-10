type id = Symbol.symbol
  [@@deriving show]

type binop =
  | Plus
  | Minus
  | Times
  | Div
  [@@deriving show]


type stm =
  | CompoundStm of stm * stm
  | AssignStm of id * exp
  | PrintStm of exp list
  [@@deriving show]

and exp =
  | IdExp of id
  | NumExp of float
  | OpExp of binop * exp * exp
  | EseqExp of stm * exp
  [@@deriving show]

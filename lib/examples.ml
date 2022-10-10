(* some example programs *)

open Ast

(*
  print(19)
   *)
let prog1 = PrintStm [NumExp 19.]

(*
  peso := 73
 *)

let prog2 = AssignStm (Symbol.symbol "peso", NumExp 73.)

(*
  print(43, 7, 0)
 *)

let prog3 = PrintStm [NumExp 43.; NumExp 7.; NumExp 0.]

(*
  x := 2 + 3;
  print(x)
 *)

let prog4 =
  CompoundStm (AssignStm (Symbol.symbol "x", OpExp (Plus, NumExp 2., NumExp 3.)),
               PrintStm [IdExp (Symbol.symbol "x")])

(*
  x := 2 + 3 * 4;
  print(x)

 *)

let prog5 =
  CompoundStm (AssignStm (Symbol.symbol "x",
                          OpExp (Plus,
                                 NumExp 2.,
                                 OpExp (Times,
                                        NumExp 3.,
                                        NumExp 4.))),
               PrintStm [IdExp (Symbol.symbol "x")])

(*
  a := 5 + 3;
  b := (print(a, a-1), 10*a);
  print(b)
 *)

let prog6 =
  CompoundStm (AssignStm (Symbol.symbol "a",
                          OpExp (Plus,
                                 NumExp 5.,
                                 NumExp 3.)),
               CompoundStm (AssignStm (Symbol.symbol "b", EseqExp (PrintStm [IdExp (Symbol.symbol "a");
                                                               OpExp (Minus,
                                                                      IdExp (Symbol.symbol "a"),
                                                                      NumExp 1.)],
                                                     OpExp (Times,
                                                            NumExp 10.,
                                                            IdExp (Symbol.symbol "a")))),
                            PrintStm [IdExp (Symbol.symbol "b")]))

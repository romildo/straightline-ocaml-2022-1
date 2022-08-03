(* some example programs *)

open Ast

let prog1 = PrintStm [NumExp 19]

(*
  peso := 73
 *)

let prog2 = AssignStm ("peso", NumExp 73)

(*
  print(43, 7, 0)
 *)

let prog3 = PrintStm [NumExp 43; NumExp 7; NumExp 0]

(*
  x := 2 + 3;
  print(x)
 *)

let prog4 =
  CompoundStm (AssignStm ("x", OpExp (NumExp 2, Plus, NumExp 3)),
               PrintStm [IdExp "x"])

(*
  x := 2 + 3 * 4;
  print(x)

 *)

let prog5 =
  CompoundStm (AssignStm ("x",
                          OpExp (NumExp 2,
                                 Plus,
                                 OpExp (NumExp 3,
                                        Times,
                                        NumExp 4))),
               PrintStm [IdExp "x"])

(*
  a := 5 + 3;
  b := (print(a, a-1), 10*a);
  print(b)
 *)

let prog6 =
  CompoundStm (AssignStm ("a",
                          OpExp (NumExp 5,
                                 Plus,
                                 NumExp 3)),
               CompoundStm (AssignStm ("b", EseqExp (PrintStm [IdExp "a";
                                                               OpExp (IdExp "a",
                                                                      Minus,
                                                                      NumExp 1)],
                                                     OpExp (NumExp 10,
                                                            Times,
                                                            IdExp "a"))),
                            PrintStm [IdExp "b"]))

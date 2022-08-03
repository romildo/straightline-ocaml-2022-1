(* maxargs *)

open Ast

let rec maxargs stm =
  match stm with
  | CompoundStm (s1, s2) -> max (maxargs s1) (maxargs s2)
  | AssignStm (_, e) -> maxargs_exp e
  | PrintStm es -> max (List.length es) (maxargs_exp_list es)

and maxargs_exp exp =
  match exp with
  | IdExp _ -> 0
  | NumExp _ -> 0
  | OpExp (e1, _, e2) -> max (maxargs_exp e1) (maxargs_exp e2)
  | EseqExp (s, e) -> max (maxargs s) (maxargs_exp e)

and maxargs_exp_list exp_list =
  List.fold_left (+) 0 (List.map maxargs_exp exp_list)

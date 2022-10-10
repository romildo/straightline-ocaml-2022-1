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
  | OpExp (_, e1, e2) -> max (maxargs_exp e1) (maxargs_exp e2)
  | EseqExp (s, e) -> max (maxargs s) (maxargs_exp e)

(* definition using direct recursion *)
and maxargs_exp_list list =
  match list with
  | [] -> 0
  | e :: es -> max (maxargs_exp e) (maxargs_exp_list es)

(* alternative definition using higher order functions *)
and maxargs_exp_list_alt exp_list =
  List.fold_left (+) 0 (List.map maxargs_exp exp_list)

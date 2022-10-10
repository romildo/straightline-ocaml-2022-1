(* totree *)

open Ast

let text = PrintBox.text
let tree = PrintBox.tree

let rec stm_to_tree stm =
  match stm with
  | CompoundStm (s1, s2) ->
     tree (text "CompoundStm") [stm_to_tree s1; stm_to_tree s2]
  | AssignStm (id, e) ->
     tree (text "AssignStm") [text (Symbol.name id); exp_to_tree e]
  | PrintStm es ->
     tree (text "PrintStm") (List.map exp_to_tree es)

and exp_to_tree exp =
  match exp with
  | IdExp id ->
     tree (text ("IdExp " ^ Symbol.name id)) []
  | NumExp c ->
     tree (text ("NumExp " ^ string_of_float c)) []
  | OpExp (op, e1, e2) ->
     tree (text ("OpExp " ^ binop_to_string op)) [exp_to_tree e1; exp_to_tree e2]
  | EseqExp (s, e) ->
     tree (text "EseqExp") [stm_to_tree s; exp_to_tree e]

and binop_to_string op =
  match op with
  | Plus -> "+"
  | Minus -> "-"
  | Times -> "*"
  | Div -> "/"
